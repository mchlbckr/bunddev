#' Get flood gauge information
#'
#' @param pegelnummer Pegelnummer identifier (e.g., "HE_24820206").
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#'
#' @details
#' Returns metadata for a single flood gauge (pegel) from
#' hochwasserzentralen.de. Official docs:
#' https://bundesapi.github.io/hochwasserzentralen-api/.
#'
#' @examples
#' \dontrun{
#' hochwasserzentralen_pegel_info("HE_24820206")
#' }
#'
#' @return A tibble with pegel metadata.
#'
#' Use `bunddev_parameters("hochwasserzentralen")` to see the currently valid
#' parameters if the API has changed.
#' @export
hochwasserzentralen_pegel_info <- function(pegelnummer, safe = TRUE, refresh = FALSE) {
  params <- list(pgnr = pegelnummer)
  response <- hochwasserzentralen_request(
    "/webservices/get_infospegel.php",
    params = params,
    method = "POST",
    safe = safe,
    refresh = refresh
  )

  hochwasserzentralen_tidy_table(response)
}

#' List flood portal states and connected regions
#'
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#'
#' @details
#' Returns metadata for all Bundeslaender and connected regions in the
#' hochwasserzentralen.de portal. Official docs:
#' https://bundesapi.github.io/hochwasserzentralen-api/.
#'
#' @examples
#' \dontrun{
#' hochwasserzentralen_bundeslaender()
#' }
#'
#' @return A tibble with Bundesland metadata.
#'
#' Use `bunddev_parameters("hochwasserzentralen")` to see the currently valid
#' parameters if the API has changed.
#' @export
hochwasserzentralen_bundeslaender <- function(safe = TRUE, refresh = FALSE) {
  response <- hochwasserzentralen_request(
    "/webservices/get_infosbundesland.php",
    method = "GET",
    safe = safe,
    refresh = refresh
  )

  hochwasserzentralen_tidy_table(response)
}

#' Get flood portal metadata for a Bundesland
#'
#' @param bundesland_id Bundesland id (e.g., "HE").
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#'
#' @details
#' Returns metadata for a single Bundesland or region in the
#' hochwasserzentralen.de portal. Official docs:
#' https://bundesapi.github.io/hochwasserzentralen-api/.
#'
#' @examples
#' \dontrun{
#' hochwasserzentralen_bundesland_info("HE")
#' }
#'
#' @return A tibble with Bundesland metadata.
#'
#' Use `bunddev_parameters("hochwasserzentralen")` to see the currently valid
#' parameters if the API has changed.
#' @export
hochwasserzentralen_bundesland_info <- function(bundesland_id, safe = TRUE, refresh = FALSE) {
  params <- list(id = bundesland_id)
  response <- hochwasserzentralen_request(
    "/webservices/get_infosbundesland.php",
    params = params,
    method = "POST",
    safe = safe,
    refresh = refresh
  )

  hochwasserzentralen_tidy_table(response)
}

#' List flood gauge locations
#'
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#'
#' @details
#' Returns latitude/longitude coordinates for all pegel identifiers available
#' in the hochwasserzentralen.de portal. Official docs:
#' https://bundesapi.github.io/hochwasserzentralen-api/.
#'
#' @examples
#' \dontrun{
#' hochwasserzentralen_lagepegel()
#' }
#'
#' @return A tibble with pegel coordinates.
#'
#' Use `bunddev_parameters("hochwasserzentralen")` to see the currently valid
#' parameters if the API has changed.
#' @export
hochwasserzentralen_lagepegel <- function(safe = TRUE, refresh = FALSE) {
  response <- hochwasserzentralen_request(
    "/webservices/get_lagepegel.php",
    method = "GET",
    safe = safe,
    refresh = refresh
  )

  hochwasserzentralen_tidy_table(response)
}

#' Get Bundesland GeoJSON boundaries
#'
#' @param version GeoJSON version identifier (e.g., "20211130").
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' Returns GeoJSON boundaries for Bundeslaender and connected regions from the
#' hochwasserzentralen.de portal. Official docs:
#' https://bundesapi.github.io/hochwasserzentralen-api/.
#'
#' @examples
#' \dontrun{
#' hochwasserzentralen_bundesland_geojson("20211130", flatten = TRUE)
#' }
#'
#' @return A tibble with GeoJSON metadata and feature list-columns.
#'
#' Use `bunddev_parameters("hochwasserzentralen")` to see the currently valid
#' parameters if the API has changed.
#' @export
hochwasserzentralen_bundesland_geojson <- function(version,
                                                   safe = TRUE,
                                                   refresh = FALSE,
                                                   flatten = FALSE,
                                                   flatten_mode = "json") {
  path <- paste0("/vhosts/geojson/bundesland.", version, ".geojson")
  response <- hochwasserzentralen_request(
    path,
    method = "GET",
    safe = safe,
    refresh = refresh
  )

  data <- hochwasserzentralen_tidy_geojson(response)
  if (flatten) {
    return(bunddev_flatten_list_cols(data, cols = "features", mode = flatten_mode))
  }

  data
}

hochwasserzentralen_request <- function(path,
                                        params = list(),
                                        method = "GET",
                                        safe = TRUE,
                                        refresh = FALSE,
                                        parse = "json",
                                        operation_id = NULL) {
  spec <- bunddev_spec("hochwasserzentralen")
  base_url <- spec$servers[[1]]$url
  url <- paste0(stringr::str_remove(base_url, "/$"), path)

  if (isTRUE(safe)) {
    bunddev_rate_limit_wait("hochwasserzentralen")
  }

  method_lower <- tolower(method)
  cache_path <- NULL
  if (isTRUE(safe) && method_lower == "get") {
    if (is.null(operation_id)) {
      operation_id <- stringr::str_replace_all(path, "[^A-Za-z0-9]+", "_")
    }
    cache_path <- bunddev_response_cache_path("hochwasserzentralen", operation_id, params)
    if (!isTRUE(refresh) && file.exists(cache_path)) {
      raw_body <- readBin(cache_path, "raw", n = file.info(cache_path)$size)
      return(bunddev_parse_response(raw_body, parse))
    }
  }

  req <- httr2::request(url)
  req <- httr2::req_method(req, method)

  if (length(params) > 0) {
    if (method_lower == "post") {
      req <- httr2::req_body_form(req, !!!params)
    } else {
      req <- httr2::req_url_query(req, !!!params)
    }
  }

  resp <- httr2::req_perform(req)
  raw_body <- tryCatch(
    httr2::resp_body_raw(resp),
    error = function(e) raw(0)
  )

  if (length(raw_body) == 0) {
    return(list())
  }

  if (!is.null(cache_path)) {
    writeBin(raw_body, cache_path)
  }

  bunddev_parse_response(raw_body, parse)
}

hochwasserzentralen_tidy_table <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  if (!is.list(response)) {
    return(tibble::tibble(value = response))
  }

  columns <- purrr::imap(response, function(value, name) {
    if (is.null(value)) {
      return(NA_character_)
    }
    if (is.list(value) && !is.data.frame(value)) {
      value <- unlist(value, recursive = FALSE, use.names = FALSE)
    }
    value
  })

  tibble::tibble(!!!columns)
}

hochwasserzentralen_tidy_geojson <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  tibble::tibble(
    type = response$type %||% NA_character_,
    name = response$name %||% NA_character_,
    features = list(response$features %||% response$fetures %||% list())
  )
}

bunddev_hochwasserzentralen_pegel_info <- function(pegelnummer, safe = TRUE, refresh = FALSE) {
  hochwasserzentralen_pegel_info(pegelnummer = pegelnummer, safe = safe, refresh = refresh)
}

bunddev_hochwasserzentralen_bundeslaender <- function(safe = TRUE, refresh = FALSE) {
  hochwasserzentralen_bundeslaender(safe = safe, refresh = refresh)
}

bunddev_hochwasserzentralen_bundesland_info <- function(bundesland_id, safe = TRUE, refresh = FALSE) {
  hochwasserzentralen_bundesland_info(bundesland_id = bundesland_id, safe = safe, refresh = refresh)
}

bunddev_hochwasserzentralen_lagepegel <- function(safe = TRUE, refresh = FALSE) {
  hochwasserzentralen_lagepegel(safe = safe, refresh = refresh)
}

bunddev_hochwasserzentralen_bundesland_geojson <- function(version,
                                                           safe = TRUE,
                                                           refresh = FALSE,
                                                           flatten = FALSE,
                                                           flatten_mode = "json") {
  hochwasserzentralen_bundesland_geojson(
    version = version,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}
