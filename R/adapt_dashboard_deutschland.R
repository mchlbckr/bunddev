#' List Dashboard Deutschland entries
#'
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
#' Returns the full list of dashboard entries and metadata for each item.
#' API documentation: \url{https://bundesapi.github.io/dashboard-deutschland-api/}.
#'
#' @examples
#' \dontrun{
#' dashboard_deutschland_get()
#' }
#'
#' @return A tibble with one row per dashboard tile:
#' \describe{
#'   \item{id}{Tile identifier (character).}
#'   \item{name}{Title in German (character).}
#'   \item{name_en}{Title in English (character).}
#'   \item{description}{Description in German (character).}
#'   \item{description_en}{Description in English (character).}
#'   \item{teaser}{Teaser text in German (character).}
#'   \item{teaser_en}{Teaser text in English (character).}
#'   \item{conclusion}{Conclusion text in German (character).}
#'   \item{conclusion_en}{Conclusion text in English (character).}
#'   \item{category}{Category metadata (list-column).}
#'   \item{tags}{Tag metadata (list-column).}
#'   \item{image}{Image path/url (character).}
#'   \item{clicks}{Click counter (integer).}
#'   \item{order_id}{Ordering index (integer).}
#'   \item{trending}{Whether tile is marked as trending (`TRUE`/`FALSE`).}
#'   \item{top}{Whether tile is marked as top (`TRUE`/`FALSE`).}
#'   \item{layout_tiles}{Layout tile metadata (list-column).}
#'   \item{layout_mode}{Layout mode identifier (character).}
#' }
#' @family Dashboard Deutschland
#' @export
dashboard_deutschland_get <- function(safe = TRUE,
                                      refresh = FALSE,
                                      flatten = FALSE,
                                      flatten_mode = "json") {
  response <- bunddev_call(
    "dashboard_deutschland",
    "get",
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  data <- dashboard_deutschland_tidy_get(response)
  if (flatten) {
    return(bunddev_flatten_list_cols(
      data,
      cols = c("category", "tags", "layout_tiles"),
      mode = flatten_mode
    ))
  }

  data
}

#' Query Dashboard Deutschland indicators
#'
#' @param ids Indicator ids, semicolon-separated or as a character vector.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns indicator data for the specified ids. API documentation: \url{https://bundesapi.github.io/dashboard-deutschland-api/}.
#'
#' @examples
#' \dontrun{
#' dashboard_deutschland_indicators("tile_1667811574092")
#' }
#'
#' @return A tibble with one row per indicator entry:
#' \describe{
#'   \item{id}{Indicator id (character).}
#'   \item{date}{Timestamp in milliseconds since epoch (numeric).}
#'   \item{date_time}{Timestamp as `POSIXct` in Europe/Berlin.}
#'   \item{json}{Indicator payload as JSON string (character).}
#'   \item{title}{Indicator title (character).}
#' }
#' @family Dashboard Deutschland
#' @export
dashboard_deutschland_indicators <- function(ids = NULL,
                                             safe = TRUE,
                                             refresh = FALSE) {
  params <- list()
  if (!is.null(ids)) {
    if (length(ids) > 1) {
      ids <- paste(ids, collapse = ";")
    }
    params$ids <- ids
  }

  response <- bunddev_call(
    "dashboard_deutschland",
    "indicators",
    params = params,
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  dashboard_deutschland_tidy_indicators(response)
}

#' Get Dashboard Deutschland GeoJSON
#'
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
#' Returns GeoJSON data for Germany and the federal states.
#' API documentation: \url{https://bundesapi.github.io/dashboard-deutschland-api/}.
#'
#' @examples
#' \dontrun{
#' dashboard_deutschland_geo(flatten = TRUE)
#' }
#'
#' @return A one-row tibble with GeoJSON container metadata:
#' \describe{
#'   \item{type}{GeoJSON object type (character).}
#'   \item{name}{Dataset name (character).}
#'   \item{title}{Dataset title (character).}
#'   \item{version}{Version identifier (character).}
#'   \item{copyright_short}{Short copyright label (character).}
#'   \item{copyright_url}{Copyright URL (character).}
#'   \item{crs}{Coordinate reference system metadata (list-column).}
#'   \item{features}{GeoJSON feature collection entries (list-column).}
#' }
#' @family Dashboard Deutschland
#' @export
dashboard_deutschland_geo <- function(safe = TRUE,
                                      refresh = FALSE,
                                      flatten = FALSE,
                                      flatten_mode = "json") {
  response <- bunddev_call(
    "dashboard_deutschland",
    "geo",
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  data <- dashboard_deutschland_tidy_geo(response)
  if (flatten) {
    return(bunddev_flatten_list_cols(
      data,
      cols = c("crs", "features"),
      mode = flatten_mode
    ))
  }

  data
}

dashboard_deutschland_tidy_get <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  to_chr <- function(value) {
    if (is.null(value)) NA_character_ else as.character(value)
  }
  to_lgl <- function(value) {
    if (is.null(value)) NA else isTRUE(value)
  }
  to_int <- function(value) {
    if (is.null(value)) NA_integer_ else as.integer(value)
  }

  tibble::tibble(
    id = purrr::map_chr(response, ~ to_chr(.x$id)),
    name = purrr::map_chr(response, ~ to_chr(.x$name)),
    name_en = purrr::map_chr(response, ~ to_chr(.x$nameEn)),
    description = purrr::map_chr(response, ~ to_chr(.x$description)),
    description_en = purrr::map_chr(response, ~ to_chr(.x$descriptionEn)),
    teaser = purrr::map_chr(response, ~ to_chr(.x$teaser)),
    teaser_en = purrr::map_chr(response, ~ to_chr(.x$teaserEn)),
    conclusion = purrr::map_chr(response, ~ to_chr(.x$conclusion)),
    conclusion_en = purrr::map_chr(response, ~ to_chr(.x$conclusionEn)),
    category = purrr::map(response, ~ .x$category %||% list()),
    tags = purrr::map(response, ~ .x$tags %||% list()),
    image = purrr::map_chr(response, ~ to_chr(.x$image)),
    clicks = purrr::map_int(response, ~ to_int(.x$clicks)),
    order_id = purrr::map_int(response, ~ to_int(.x$orderId)),
    trending = purrr::map_lgl(response, ~ to_lgl(.x$trending)),
    top = purrr::map_lgl(response, ~ to_lgl(.x$top)),
    layout_tiles = purrr::map(response, ~ .x$layoutTiles %||% list()),
    layout_mode = purrr::map_chr(response, ~ to_chr(.x$layoutMode))
  )
}

dashboard_deutschland_tidy_indicators <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  to_chr <- function(value) {
    if (is.null(value)) NA_character_ else as.character(value)
  }
  to_num <- function(value) {
    if (is.null(value)) NA_real_ else as.numeric(value)
  }

  dates <- purrr::map_dbl(response, ~ to_num(.x$date))

  tibble::tibble(
    id = purrr::map_chr(response, ~ to_chr(.x$id)),
    date = dates,
    date_time = bunddev_ms_to_posix(dates),
    json = purrr::map_chr(response, ~ to_chr(.x$json)),
    title = purrr::map_chr(response, ~ to_chr(.x$title))
  )
}

dashboard_deutschland_tidy_geo <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  tibble::tibble(
    type = response$type %||% NA_character_,
    name = response$name %||% NA_character_,
    title = response$title %||% NA_character_,
    version = response$version %||% NA_character_,
    copyright_short = response$copyrightShort %||% NA_character_,
    copyright_url = response$copyrightUrl %||% NA_character_,
    crs = list(response$crs %||% list()),
    features = list(response$features %||% list())
  )
}

bunddev_dashboard_deutschland_get <- function(safe = TRUE,
                                              refresh = FALSE,
                                              flatten = FALSE,
                                              flatten_mode = "json") {
  dashboard_deutschland_get(
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_dashboard_deutschland_indicators <- function(ids = NULL,
                                                     safe = TRUE,
                                                     refresh = FALSE) {
  dashboard_deutschland_indicators(ids = ids, safe = safe, refresh = refresh)
}

bunddev_dashboard_deutschland_geo <- function(safe = TRUE,
                                              refresh = FALSE,
                                              flatten = FALSE,
                                              flatten_mode = "json") {
  dashboard_deutschland_geo(
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}
