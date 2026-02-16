#' Query Deutschlandatlas indicators
#'
#' @param table Table id (default "p_apo_f_ZA2022").
#' @param params Named list of ArcGIS query parameters:
#'   \describe{
#'     \item{where}{SQL-like filter expression (required by this adapter).}
#'     \item{f}{Output format (`"json"` default).}
#'     \item{outFields}{Fields to return (`"*"` default).}
#'     \item{returnGeometry}{Whether to include geometry (`"true"`/`"false"`).}
#'     \item{spatialRel}{Spatial relation, e.g. `"esriSpatialRelIntersects"`.}
#'     \item{geometry}{Optional geometry filter (JSON string or R list).}
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
#' The Deutschlandatlas API is backed by an ArcGIS feature service. You must
#' supply a `where` filter and output format `f` (usually "json"). API documentation: \url{https://github.com/AndreasFischer1985/deutschlandatlas-api}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#'
#' @examples
#' \dontrun{
#' deutschlandatlas_query(
#'   table = "p_apo_f_ZA2022",
#'   params = list(
#'     where = "1=1",
#'     outFields = "*",
#'     f = "json",
#'     returnGeometry = "false",
#'     resultRecordCount = 5
#'   )
#' )
#' }
#'
#' @return A tibble with one row per ArcGIS feature. Attribute names are
#' normalized to lower snake_case. Includes a `geometry` list-column.
#' \describe{
#'   \item{Attribute columns}{One column per ArcGIS `attributes` field (sanitized to snake_case).}
#'   \item{geometry}{Geometry object as list-column when requested/available.}
#' }
#' @family Deutschlandatlas
#' @export
deutschlandatlas_query <- function(table = "p_apo_f_ZA2022",
                                   params = list(),
                                   safe = TRUE,
                                   refresh = FALSE,
                                   flatten = FALSE,
                                   flatten_mode = "json") {
  if (is.null(params$where)) {
    cli::cli_abort("'where' is required for deutschlandatlas_query().")
  }
  if (is.null(params$f)) {
    params$f <- "json"
  }
  if (is.null(params$outFields)) {
    params$outFields <- "*"
  }
  if (is.null(params$returnGeometry)) {
    params$returnGeometry <- "false"
  }

  if (is.list(params$geometry)) {
    params$geometry <- jsonlite::toJSON(params$geometry, auto_unbox = TRUE)
  }

  params$table <- table

  response <- bunddev_call(
    "deutschlandatlas",
    "query",
    params = params,
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  data <- deutschlandatlas_tidy_response(response)
  if (flatten) {
    return(bunddev_flatten_list_cols(data, cols = c("geometry"), mode = flatten_mode))
  }

  data
}

deutschlandatlas_tidy_response <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }
  if (!is.null(response$error)) {
    message <- response$error$message %||% "ArcGIS request failed."
    cli::cli_abort(message)
  }

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

bunddev_deutschlandatlas_query <- function(table = "p_apo_f_ZA2022",
                                           params = list(),
                                           safe = TRUE,
                                           refresh = FALSE,
                                           flatten = FALSE,
                                           flatten_mode = "json") {
  deutschlandatlas_query(
    table = table,
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}
