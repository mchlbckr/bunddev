#' Query charging stations
#'
#' @param params Query parameters for the ArcGIS service.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' The Ladesaeulenregister API is backed by an ArcGIS feature service. You must
#' supply a `geometry` filter and `outFields`. The API may require a `token`
#' query parameter depending on service settings. Official docs:
#' https://ladestationen.api.bund.dev.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#'
#' @examples
#' \dontrun{
#' geometry <- jsonlite::toJSON(
#'   list(
#'     xmin = 13.3, ymin = 52.4, xmax = 13.5, ymax = 52.6,
#'     spatialReference = list(wkid = 4326)
#'   ),
#'   auto_unbox = TRUE
#' )
#' ladestationen_query(params = list(
#'   geometry = geometry,
#'   geometryType = "esriGeometryEnvelope",
#'   where = "1=1",
#'   outFields = "*",
#'   outSR = 4326,
#'   f = "json",
#'   returnGeometry = "false",
#'   resultRecordCount = 5
#' ))
#' }
#'
#' @return A tibble with charging station records.
#'
#' Use `bunddev_parameters("ladestationen")` to see the currently valid parameters
#' if the API has changed.
#' @export
ladestationen_query <- function(params = list(),
                                safe = TRUE,
                                refresh = FALSE,
                                flatten = FALSE,
                                flatten_mode = "json") {
  if (is.null(params$geometry)) {
    cli::cli_abort("'geometry' is required for ladestationen_query().")
  }
  if (is.null(params$outFields)) {
    params$outFields <- "*"
  }
  if (is.null(params$f)) {
    params$f <- "json"
  }

  if (is.list(params$geometry)) {
    params$geometry <- jsonlite::toJSON(params$geometry, auto_unbox = TRUE)
  }

  response <- ladestationen_request(params, safe = safe, refresh = refresh)
  data <- ladestationen_tidy_response(response)

  if (flatten) {
    return(bunddev_flatten_list_cols(data, cols = c("geometry"), mode = flatten_mode))
  }

  data
}

ladestationen_request <- function(params, safe = TRUE, refresh = FALSE) {
  spec <- bunddev_spec("ladestationen")
  servers <- spec$paths[["/query"]]$get$servers
  if (is.null(servers) || length(servers) == 0) {
    cli::cli_abort("No server URL defined in ladestationen OpenAPI spec.")
  }
  base_url <- servers[[1]]$url
  url <- paste0(stringr::str_remove(base_url, "/$"), "/query")

  if (isTRUE(safe)) {
    bunddev_rate_limit_wait("ladestationen")
  }

  cache_path <- NULL
  if (isTRUE(safe)) {
    cache_path <- bunddev_response_cache_path("ladestationen", "query", params)
    if (!isTRUE(refresh) && file.exists(cache_path)) {
      raw_body <- readBin(cache_path, "raw", n = file.info(cache_path)$size)
      return(bunddev_parse_response(raw_body, "json"))
    }
  }

  req <- httr2::request(url) |> httr2::req_url_query(!!!params)
  resp <- httr2::req_perform(req)
  raw_body <- httr2::resp_body_raw(resp)
  parsed <- bunddev_parse_response(raw_body, "json")

  if (!is.null(parsed$error)) {
    message <- parsed$error$message %||% "ArcGIS request failed."
    cli::cli_abort(message)
  }

  if (!is.null(cache_path)) {
    writeBin(raw_body, cache_path)
  }

  parsed
}

ladestationen_tidy_response <- function(response) {
  features <- response$features
  if (is.null(features) || length(features) == 0) {
    return(tibble::tibble())
  }

  sanitize_name <- function(name) {
    ascii <- iconv(name, from = "UTF-8", to = "ASCII//TRANSLIT")
    ascii <- stringr::str_replace_all(ascii, "[^A-Za-z0-9]+", "_")
    ascii <- stringr::str_replace_all(ascii, "^_+|_+$", "")
    tolower(ascii)
  }

  rows <- purrr::map(features, function(feature) {
    attrs <- feature$attributes %||% list()
    geometry <- feature$geometry %||% list()
    attrs$geometry <- geometry
    attrs
  })

  data <- dplyr::bind_rows(rows)
  names(data) <- vapply(names(data), sanitize_name, character(1))
  data
}

bunddev_ladestationen_query <- function(params = list(),
                                        safe = TRUE,
                                        refresh = FALSE,
                                        flatten = FALSE,
                                        flatten_mode = "json") {
  ladestationen_query(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}
