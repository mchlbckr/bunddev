#' Call an API operation
#'
#' @param api Registry id.
#' @param operation_id OpenAPI operationId.
#' @param params List of parameters.
#' @param parse Response parsing mode.
#'
#' @return Parsed response.
#' @export
bunddev_call <- function(api, operation_id, params = list(),
                         parse = c("json", "text", "raw")) {
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

  if (is.null(spec$servers) || length(spec$servers) == 0) {
    cli::cli_abort("OpenAPI spec has no servers defined.")
  }
  base_url <- spec$servers[[1]]$url
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

  req <- httr2::request(url)
  req <- httr2::req_method(req, toupper(endpoint$method))

  if (length(params) > 0) {
    req <- httr2::req_url_query(req, !!!params)
  }

  auth <- bunddev_auth_get(api)
  if (auth$type == "api_key") {
    if (is.na(auth$env_var) || auth$env_var == "") {
      cli::cli_abort("API key env_var is not set for '{api}'.")
    }
    api_key <- Sys.getenv(auth$env_var)
    if (api_key == "") {
      cli::cli_abort("Environment variable '{auth$env_var}' is not set.")
    }
    req <- httr2::req_headers(req, "X-API-Key" = api_key)
  } else if (auth$type == "oauth2") {
    cli::cli_abort("OAuth2 is not supported in this package.")
  }

  resp <- httr2::req_perform(req)

  if (parse == "json") {
    return(httr2::resp_body_json(resp, simplifyVector = FALSE))
  }
  if (parse == "text") {
    return(httr2::resp_body_string(resp))
  }

  httr2::resp_body_raw(resp)
}
