#' Call an API operation
#'
#' @param api Registry id.
#' @param operation_id OpenAPI operationId.
#' @param params List of parameters.
#' @param parse Response parsing mode.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached GET responses.
#'
#' @details
#' This is the low-level OpenAPI caller. It resolves an `operation_id` from the
#' cached OpenAPI spec, fills path parameters from `params`, applies auth (if
#' configured), and optionally caches GET responses when `safe = TRUE`.
#'
#' Use [bunddev_parameters()] and [bunddev_parameter_values()] to discover valid
#' parameters before calling.
#'
#' @seealso
#' [bunddev_call_tidy()] for adapter-specific tidy outputs, and
#' [bunddev_auth_set()] to configure API keys.
#'
#' @examples
#' 
#' # Retrieve Autobahn road ids (raw response)
#' bunddev_call("autobahn", "list-autobahnen")
#'
#' @return Parsed response.
#' @export
bunddev_call <- function(api, operation_id, params = list(),
                         parse = c("json", "text", "raw"),
                         safe = TRUE, refresh = FALSE) {
  parse <- rlang::arg_match(parse)
  spec <- bunddev_spec(api)

  endpoints <- purrr::imap(spec$paths, function(path_item, path) {
    if (!is.list(path_item)) {
      return(NULL)
    }
    methods <- names(path_item)
    purrr::map(methods, function(method) {
      operation <- path_item[[method]]
      if (is.null(operation$operationId)) {
        return(NULL)
      }
      list(
        method = method,
        path = path,
        operation_id = operation$operationId,
        operation = operation
      )
    })
  })

  endpoints <- purrr::flatten(endpoints)
  endpoints <- purrr::compact(endpoints)

  match <- purrr::keep(endpoints, ~ .x$operation_id == operation_id)
  if (length(match) == 0) {
    cli::cli_abort("Operation '{operation_id}' not found for API '{api}'.")
  }
  endpoint <- match[[1]]

  # Handle OpenAPI 3.0 (servers) and Swagger 2.0 (host + basePath) formats
  # Priority: operation-level servers > path-level servers > global servers > Swagger 2.0 host

  # 1. Check for operation-level servers (path-specific overrides in OpenAPI 3.0)
  if (!is.null(endpoint$operation$servers) && length(endpoint$operation$servers) > 0) {
    base_url <- endpoint$operation$servers[[1]]$url
  # 2. Check for path-level servers
  } else if (!is.null(spec$paths[[endpoint$path]]$servers) &&
             length(spec$paths[[endpoint$path]]$servers) > 0) {
    base_url <- spec$paths[[endpoint$path]]$servers[[1]]$url
  # 3. Fall back to global servers (OpenAPI 3.0)
  } else if (!is.null(spec$servers) && length(spec$servers) > 0) {
    base_url <- spec$servers[[1]]$url
  # 4. Fall back to Swagger 2.0 format
  } else if (!is.null(spec$host)) {
    scheme <- if (!is.null(spec$schemes)) spec$schemes[1] else "https"
    base_path <- spec$basePath %||% ""
    base_url <- paste0(scheme, "://", spec$host, base_path)
  } else {
    cli::cli_abort("OpenAPI spec has no servers or host defined.")
  }

  if (is.null(base_url) || base_url == "") {
    cli::cli_abort("OpenAPI server URL is missing.")
  }

  if (stringr::str_detect(base_url, "\\{")) {
    variables <- spec$servers[[1]]$variables
    if (is.null(variables) || !is.list(variables)) {
      cli::cli_abort("Server URL requires variables, but none are provided.")
    }
    var_matches <- stringr::str_match_all(base_url, "\\{([^}]+)\\}")[[1]]
    if (nrow(var_matches) > 0) {
      for (var_name in var_matches[, 2]) {
        default_value <- variables[[var_name]]$default
        if (is.null(default_value) || default_value == "") {
          cli::cli_abort("Server URL variable '{var_name}' has no default.")
        }
        base_url <- stringr::str_replace_all(
          base_url,
          paste0("\\{", var_name, "\\}"),
          default_value
        )
      }
    }
  }

  path <- endpoint$path
  path_params <- stringr::str_match_all(path, "\\{([^}]+)\\}")[[1]]
  if (nrow(path_params) > 0) {
    for (param in path_params[, 2]) {
      if (!param %in% names(params)) {
        cli::cli_abort("Missing path parameter '{param}'.")
      }
      value <- as.character(params[[param]])
      path <- stringr::str_replace_all(path, paste0("\\{", param, "\\}"), value)
    }
    params[path_params[, 2]] <- NULL
  }

  base_url <- stringr::str_remove(base_url, "/$")
  path <- stringr::str_remove(path, "^/")
  url <- paste0(base_url, "/", path)

  method <- toupper(endpoint$method)
  method_lower <- tolower(endpoint$method)

  if (isTRUE(safe)) {
    bunddev_rate_limit_wait(api)
  }

  cache_path <- NULL
  if (isTRUE(safe) && method_lower == "get") {
    cache_path <- bunddev_response_cache_path(api, operation_id, params)
    if (!isTRUE(refresh) && file.exists(cache_path)) {
      raw_body <- readBin(cache_path, "raw", n = file.info(cache_path)$size)
      return(bunddev_parse_response(raw_body, parse))
    }
  }

  req <- httr2::request(url)
  req <- httr2::req_method(req, method)

  if (length(params) > 0) {
    req <- httr2::req_url_query(req, !!!params)
  }

  # Handle authentication
  auth <- bunddev_auth_get(api)

  # Check if spec requires API key but none is configured - try to extract from spec
  if (auth$type == "none" && !is.null(spec$components$securitySchemes)) {
    for (scheme_name in names(spec$components$securitySchemes)) {
      scheme <- spec$components$securitySchemes[[scheme_name]]
      if (scheme$type == "apiKey" && scheme$`in` == "header") {
        # Check if description contains the API key value (for public keys)
        if (!is.null(scheme$description)) {
          # Pattern: "X-API-Key ist die Client-ID <value>"
          match <- stringr::str_match(scheme$description, "(?:Client-ID|client[_\\s-]?id)[^a-zA-Z0-9_-]+([-a-zA-Z0-9_]+)")
          if (!is.na(match[1, 2])) {
            header_list <- list()
            header_list[[scheme$name]] <- match[1, 2]
            req <- httr2::req_headers(req, !!!header_list)
            auth$type <- "public_key_from_spec"  # Mark as handled
          }
        }
      }
    }
  }

  if (auth$type == "api_key") {
    token <- bunddev_auth_token(api)

    # Determine header name from OpenAPI spec security schemes
    header_name <- "Authorization"
    if (!is.null(spec$components$securitySchemes)) {
      # Find the first apiKey scheme
      for (scheme_name in names(spec$components$securitySchemes)) {
        scheme <- spec$components$securitySchemes[[scheme_name]]
        if (scheme$type == "apiKey" && scheme$`in` == "header") {
          header_name <- scheme$name
          break
        }
      }
    } else if (!is.null(spec$securityDefinitions)) {
      # Swagger 2.0 format
      for (scheme_name in names(spec$securityDefinitions)) {
        scheme <- spec$securityDefinitions[[scheme_name]]
        if (scheme$type == "apiKey" && scheme$`in` == "header") {
          header_name <- scheme$name
          break
        }
      }
    }

    # Set the header with just the token value (no scheme prefix for custom headers)
    if (header_name == "Authorization") {
      auth_value <- bunddev_auth_header(api, token)
    } else {
      auth_value <- token
    }

    header_list <- list()
    header_list[[header_name]] <- auth_value
    req <- httr2::req_headers(req, !!!header_list)
  } else if (auth$type == "oauth2") {
    cli::cli_abort("OAuth2 is not supported in this package.")
  }

  resp <- httr2::req_perform(req)
  raw_body <- httr2::resp_body_raw(resp)

  if (!is.null(cache_path)) {
    writeBin(raw_body, cache_path)
  }

  bunddev_parse_response(raw_body, parse)
}

bunddev_parse_response <- function(raw_body, parse) {
  if (parse == "json") {
    return(jsonlite::fromJSON(rawToChar(raw_body), simplifyVector = FALSE))
  }
  if (parse == "text") {
    return(rawToChar(raw_body))
  }

  raw_body
}
