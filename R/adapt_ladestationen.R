#' Query charging stations
#'
#' @param params Named list of ArcGIS query parameters. Common keys:
#'   \describe{
#'     \item{geometry}{Geometry filter (required by this adapter). Can be a JSON
#'       string or an R list that is converted to JSON.}
#'     \item{geometryType}{Geometry type, e.g. `"esriGeometryEnvelope"`.}
#'     \item{where}{SQL-like filter expression (default often `"1=1"`).}
#'     \item{outFields}{Fields to return (default `"*"`).}
#'     \item{returnGeometry}{Whether to include feature geometry (`"true"`/`"false"`).}
#'     \item{outSR}{Output spatial reference id, e.g. `4326`.}
#'     \item{f}{Output format (default `"json"`).}
#'     \item{resultRecordCount}{Maximum number of returned rows (integer).}
#'     \item{token}{Optional ArcGIS access token if required by upstream service.}
#'   }
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#' @param flatten Logical; if `TRUE`, simplify nested list columns according to
#'   `flatten_mode`. Default `FALSE` keeps list columns as-is.
#' @param flatten_mode How to handle list columns when `flatten = TRUE`:
#'   \describe{
#'     \item{`"drop"`}{Remove list columns entirely. Use when nested data is not
#'       needed.}
#'     \item{`"json"`}{Convert each list element to a JSON string. Preserves all
#'       data in a text-queryable format. This is the **default**.}
#'     \item{`"unnest"`}{Expand list columns into multiple rows via
#'       [tidyr::unnest_longer()]. **Warning:** this can significantly increase
#'       the number of rows.}
#'   }
#'
#' @details
#' The Ladesaeulenregister API is backed by an ArcGIS feature service. You must
#' supply a `geometry` filter and `outFields`. The ArcGIS service may require a
#' `token` query parameter even though the API docs describe the service as
#' public. API documentation: \url{https://ladestationen.api.bund.dev}.
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
#' @return A tibble with one row per ArcGIS feature. Attribute names are
#' normalized to lower snake_case. Includes a `geometry` list-column with the
#' feature geometry object.
#' \describe{
#'   \item{Attribute columns}{One column per ArcGIS `attributes` field (normalized to snake_case).}
#'   \item{geometry}{Feature geometry object as list-column.}
#' }
#' @family Ladestationen
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
  bunddev_call(
    "ladestationen",
    path = "/query",
    method = "GET",
    params = params,
    parse = "json",
    safe = safe,
    refresh = refresh
  )
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
