#' List MaStR filter options for electricity generation
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
#' Returns filter definitions for public electricity generation data.
#' API documentation: \url{https://github.com/bundesAPI/marktstammdaten-api}.
#'
#' @examples
#' \dontrun{
#' marktstammdaten_filters_stromerzeugung()
#' }
#'
#' @return A tibble with filter definitions. Each row describes an available
#' filter field and its selectable values/options.
#' Guaranteed columns are top-level MaStR filter/entry fields. Entry endpoints
#' always include `total` and add parsed `*Datum_time` columns when matching
#' date fields exist.
#' @family Marktstammdaten
#' @export
marktstammdaten_filters_stromerzeugung <- function(safe = TRUE,
                                                   refresh = FALSE,
                                                   flatten = FALSE,
                                                   flatten_mode = "json") {
  response <- marktstammdaten_request(
    "/Einheit/EinheitJson/GetFilterColumnsErweiterteOeffentlicheEinheitStromerzeugung",
    safe = safe,
    refresh = refresh
  )

  marktstammdaten_maybe_flatten(marktstammdaten_tidy_filters(response), flatten, flatten_mode)
}

#' List MaStR filter options for electricity consumption
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
#' Returns filter definitions for public electricity consumption data.
#' API documentation: \url{https://github.com/bundesAPI/marktstammdaten-api}.
#'
#' @examples
#' \dontrun{
#' marktstammdaten_filters_stromverbrauch()
#' }
#'
#' @return A tibble with filter definitions for electricity consumption.
#' Guaranteed columns are top-level MaStR filter/entry fields. Entry endpoints
#' always include `total` and add parsed `*Datum_time` columns when matching
#' date fields exist.
#' @family Marktstammdaten
#' @export
marktstammdaten_filters_stromverbrauch <- function(safe = TRUE,
                                                   refresh = FALSE,
                                                   flatten = FALSE,
                                                   flatten_mode = "json") {
  response <- marktstammdaten_request(
    "/Einheit/EinheitJson/GetFilterColumnsErweiterteOeffentlicheEinheitStromverbrauch",
    safe = safe,
    refresh = refresh
  )

  marktstammdaten_maybe_flatten(marktstammdaten_tidy_filters(response), flatten, flatten_mode)
}

#' List MaStR filter options for gas generation
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
#' Returns filter definitions for public gas generation data.
#' API documentation: \url{https://github.com/bundesAPI/marktstammdaten-api}.
#'
#' @examples
#' \dontrun{
#' marktstammdaten_filters_gaserzeugung()
#' }
#'
#' @return A tibble with filter definitions for gas generation.
#' Guaranteed columns are top-level MaStR filter/entry fields. Entry endpoints
#' always include `total` and add parsed `*Datum_time` columns when matching
#' date fields exist.
#' @family Marktstammdaten
#' @export
marktstammdaten_filters_gaserzeugung <- function(safe = TRUE,
                                                 refresh = FALSE,
                                                 flatten = FALSE,
                                                 flatten_mode = "json") {
  response <- marktstammdaten_request(
    "/Einheit/EinheitJson/GetFilterColumnsErweiterteOeffentlicheEinheitGaserzeugung",
    safe = safe,
    refresh = refresh
  )

  marktstammdaten_maybe_flatten(marktstammdaten_tidy_filters(response), flatten, flatten_mode)
}

#' List MaStR filter options for gas consumption
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
#' Returns filter definitions for public gas consumption data.
#' API documentation: \url{https://github.com/bundesAPI/marktstammdaten-api}.
#'
#' @examples
#' \dontrun{
#' marktstammdaten_filters_gasverbrauch()
#' }
#'
#' @return A tibble with filter definitions for gas consumption.
#' Guaranteed columns are top-level MaStR filter/entry fields. Entry endpoints
#' always include `total` and add parsed `*Datum_time` columns when matching
#' date fields exist.
#' @family Marktstammdaten
#' @export
marktstammdaten_filters_gasverbrauch <- function(safe = TRUE,
                                                 refresh = FALSE,
                                                 flatten = FALSE,
                                                 flatten_mode = "json") {
  response <- marktstammdaten_request(
    "/Einheit/EinheitJson/GetFilterColumnsErweiterteOeffentlicheEinheitGasverbrauch",
    safe = safe,
    refresh = refresh
  )

  marktstammdaten_maybe_flatten(marktstammdaten_tidy_filters(response), flatten, flatten_mode)
}

#' List MaStR electricity generation data
#'
#' @param params Named list of query parameters:
#'   \describe{
#'     \item{sort}{Sort definition string (character).}
#'     \item{page}{Page index (integer).}
#'     \item{pageSize}{Page size/number of returned entries (integer).}
#'     \item{filter}{Serialized filter expression from filter endpoints (character).}
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
#' Returns public electricity generation data from the MaStR.
#' API documentation: \url{https://github.com/bundesAPI/marktstammdaten-api}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' marktstammdaten_stromerzeugung(params = list(page = 1, pageSize = 5))
#' }
#'
#' @return A tibble with one row per MaStR entry. Includes a `total` column with
#' the total result count and additional `_time` columns for date fields when
#' available.
#' @family Marktstammdaten
#' @export
marktstammdaten_stromerzeugung <- function(params = list(),
                                           safe = TRUE,
                                           refresh = FALSE,
                                           flatten = FALSE,
                                           flatten_mode = "json") {
  response <- marktstammdaten_request(
    "/Einheit/EinheitJson/GetErweiterteOeffentlicheEinheitStromerzeugung",
    params = params,
    safe = safe,
    refresh = refresh
  )

  marktstammdaten_maybe_flatten(marktstammdaten_tidy_entries(response), flatten, flatten_mode)
}

#' List MaStR electricity consumption data
#'
#' @inheritParams marktstammdaten_stromerzeugung
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
#' Returns public electricity consumption data from the MaStR.
#' API documentation: \url{https://github.com/bundesAPI/marktstammdaten-api}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' marktstammdaten_stromverbrauch(params = list(page = 1, pageSize = 5))
#' }
#'
#' @return A tibble with one row per electricity-consumption entry (same column
#' conventions as [marktstammdaten_stromerzeugung()]).
#' Guaranteed columns are top-level MaStR filter/entry fields. Entry endpoints
#' always include `total` and add parsed `*Datum_time` columns when matching
#' date fields exist.
#' @family Marktstammdaten
#' @export
marktstammdaten_stromverbrauch <- function(params = list(),
                                           safe = TRUE,
                                           refresh = FALSE,
                                           flatten = FALSE,
                                           flatten_mode = "json") {
  response <- marktstammdaten_request(
    "/Einheit/EinheitJson/GetErweiterteOeffentlicheEinheitStromverbrauch",
    params = params,
    safe = safe,
    refresh = refresh
  )

  marktstammdaten_maybe_flatten(marktstammdaten_tidy_entries(response), flatten, flatten_mode)
}

#' List MaStR gas generation data
#'
#' @inheritParams marktstammdaten_stromerzeugung
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
#' Returns public gas generation data from the MaStR.
#' API documentation: \url{https://github.com/bundesAPI/marktstammdaten-api}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' marktstammdaten_gaserzeugung(params = list(page = 1, pageSize = 5))
#' }
#'
#' @return A tibble with one row per gas-generation entry (same column
#' conventions as [marktstammdaten_stromerzeugung()]).
#' Guaranteed columns are top-level MaStR filter/entry fields. Entry endpoints
#' always include `total` and add parsed `*Datum_time` columns when matching
#' date fields exist.
#' @family Marktstammdaten
#' @export
marktstammdaten_gaserzeugung <- function(params = list(),
                                         safe = TRUE,
                                         refresh = FALSE,
                                         flatten = FALSE,
                                         flatten_mode = "json") {
  response <- marktstammdaten_request(
    "/Einheit/EinheitJson/GetErweiterteOeffentlicheEinheitGaserzeugung",
    params = params,
    safe = safe,
    refresh = refresh
  )

  marktstammdaten_maybe_flatten(marktstammdaten_tidy_entries(response), flatten, flatten_mode)
}

#' List MaStR gas consumption data
#'
#' @inheritParams marktstammdaten_stromerzeugung
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
#' Returns public gas consumption data from the MaStR.
#' API documentation: \url{https://github.com/bundesAPI/marktstammdaten-api}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' marktstammdaten_gasverbrauch(params = list(page = 1, pageSize = 5))
#' }
#'
#' @return A tibble with one row per gas-consumption entry (same column
#' conventions as [marktstammdaten_stromerzeugung()]).
#' Guaranteed columns are top-level MaStR filter/entry fields. Entry endpoints
#' always include `total` and add parsed `*Datum_time` columns when matching
#' date fields exist.
#' @family Marktstammdaten
#' @export
marktstammdaten_gasverbrauch <- function(params = list(),
                                         safe = TRUE,
                                         refresh = FALSE,
                                         flatten = FALSE,
                                         flatten_mode = "json") {
  response <- marktstammdaten_request(
    "/Einheit/EinheitJson/GetErweiterteOeffentlicheEinheitGasverbrauch",
    params = params,
    safe = safe,
    refresh = refresh
  )

  marktstammdaten_maybe_flatten(marktstammdaten_tidy_entries(response), flatten, flatten_mode)
}

marktstammdaten_request <- function(path,
                                     params = list(),
                                     safe = TRUE,
                                     refresh = FALSE,
                                     parse = "json") {
  bunddev_call(
    "marktstammdaten",
    path = path,
    method = "GET",
    params = params,
    parse = parse,
    safe = safe,
    refresh = refresh
  )
}

marktstammdaten_tidy_filters <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  purrr::map_dfr(response, function(item) {
    cleaned <- purrr::map(item, ~ if (is.null(.x)) NA else .x)
    tibble::as_tibble(cleaned)
  })
}

marktstammdaten_tidy_entries <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  rows <- response$Data
  if (is.null(rows) || length(rows) == 0) {
    return(tibble::tibble())
  }

  total <- response$Total %||% NA_real_

  data <- purrr::map_dfr(rows, function(item) {
    cleaned <- purrr::map(item, ~ if (is.null(.x)) NA else .x)
    tibble::as_tibble(cleaned)
  })

  data$total <- total
  marktstammdaten_add_time_cols(data)
}

marktstammdaten_add_time_cols <- function(data) {
  date_cols <- names(data)[grepl("Datum", names(data))]
  if (length(date_cols) == 0) {
    return(data)
  }

  parse_mastr_date <- function(value) {
    if (is.null(value) || length(value) == 0 || is.na(value)) {
      return(as.POSIXct(NA_character_, tz = "Europe/Berlin"))
    }
    value <- as.character(value)
    stamp <- stringr::str_match(value, "\\/Date\\(([-0-9]+)\\)\\/")[, 2]
    if (is.na(stamp)) {
      return(as.POSIXct(NA_character_, tz = "Europe/Berlin"))
    }
    bunddev_ms_to_posix(as.numeric(stamp))
  }

  for (col in date_cols) {
    data[[paste0(col, "_time")]] <- purrr::map(data[[col]], parse_mastr_date)
    data[[paste0(col, "_time")]] <- as.POSIXct(
      purrr::map_dbl(data[[paste0(col, "_time")]], as.numeric),
      origin = "1970-01-01",
      tz = "Europe/Berlin"
    )
  }

  data
}

marktstammdaten_maybe_flatten <- function(data, flatten, flatten_mode) {
  if (!isTRUE(flatten)) {
    return(data)
  }

  list_cols <- names(data)[purrr::map_lgl(data, is.list)]
  bunddev_flatten_list_cols(data, cols = list_cols, mode = flatten_mode)
}

bunddev_marktstammdaten_filters_stromerzeugung <- function(safe = TRUE,
                                                           refresh = FALSE,
                                                           flatten = FALSE,
                                                           flatten_mode = "json") {
  marktstammdaten_filters_stromerzeugung(
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_marktstammdaten_filters_stromverbrauch <- function(safe = TRUE,
                                                           refresh = FALSE,
                                                           flatten = FALSE,
                                                           flatten_mode = "json") {
  marktstammdaten_filters_stromverbrauch(
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_marktstammdaten_filters_gaserzeugung <- function(safe = TRUE,
                                                         refresh = FALSE,
                                                         flatten = FALSE,
                                                         flatten_mode = "json") {
  marktstammdaten_filters_gaserzeugung(
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_marktstammdaten_filters_gasverbrauch <- function(safe = TRUE,
                                                         refresh = FALSE,
                                                         flatten = FALSE,
                                                         flatten_mode = "json") {
  marktstammdaten_filters_gasverbrauch(
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_marktstammdaten_stromerzeugung <- function(params = list(),
                                                   safe = TRUE,
                                                   refresh = FALSE,
                                                   flatten = FALSE,
                                                   flatten_mode = "json") {
  marktstammdaten_stromerzeugung(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_marktstammdaten_stromverbrauch <- function(params = list(),
                                                   safe = TRUE,
                                                   refresh = FALSE,
                                                   flatten = FALSE,
                                                   flatten_mode = "json") {
  marktstammdaten_stromverbrauch(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_marktstammdaten_gaserzeugung <- function(params = list(),
                                                 safe = TRUE,
                                                 refresh = FALSE,
                                                 flatten = FALSE,
                                                 flatten_mode = "json") {
  marktstammdaten_gaserzeugung(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_marktstammdaten_gasverbrauch <- function(params = list(),
                                                 safe = TRUE,
                                                 refresh = FALSE,
                                                 flatten = FALSE,
                                                 flatten_mode = "json") {
  marktstammdaten_gasverbrauch(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}
