#' Bundes-Klinik-Atlas API adapters
#'
#' Functions to call the Bundes-Klinik-Atlas API endpoints.
#'
#' @keywords internal
#' @name adapt_klinikatlas
NULL

#' List Bundes-Klinik-Atlas hospital locations
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns the location directory for hospitals listed in the
#' Bundes-Klinik-Atlas. API documentation:
#' \url{https://github.com/bundesAPI/klinikatlas-api}.
#'
#' @examples
#' \dontrun{
#' klinikatlas_locations()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per hospital location.
#' @family Klinik Atlas
#' @export
klinikatlas_locations <- function(safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "klinikatlas",
    "klinikatlas_locations",
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  klinikatlas_tidy_records(response)
}

#' List Bundes-Klinik-Atlas state summaries
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns aggregate Klinik-Atlas metrics by federal state. API documentation:
#' \url{https://github.com/bundesAPI/klinikatlas-api}.
#'
#' @examples
#' \dontrun{
#' klinikatlas_states()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per federal state.
#' @family Klinik Atlas
#' @export
klinikatlas_states <- function(safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "klinikatlas",
    "klinikatlas_states",
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  klinikatlas_tidy_records(response)
}

#' List German states with coordinates from Bundes-Klinik-Atlas
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns federal states with map coordinates used by the Bundes-Klinik-Atlas.
#' API documentation: \url{https://github.com/bundesAPI/klinikatlas-api}.
#'
#' @examples
#' \dontrun{
#' klinikatlas_german_states()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per federal state.
#' @family Klinik Atlas
#' @export
klinikatlas_german_states <- function(safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "klinikatlas",
    "klinikatlas_german_states",
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  klinikatlas_tidy_records(response)
}

#' List ICD codes from Bundes-Klinik-Atlas
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns ICD code metadata used by the Bundes-Klinik-Atlas search UI.
#' API documentation: \url{https://github.com/bundesAPI/klinikatlas-api}.
#'
#' @examples
#' \dontrun{
#' klinikatlas_icd_codes()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per ICD code.
#' @family Klinik Atlas
#' @export
klinikatlas_icd_codes <- function(safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "klinikatlas",
    "klinikatlas_icd_codes",
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  klinikatlas_tidy_records(response)
}

#' List OPS codes from Bundes-Klinik-Atlas
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns OPS code metadata used by the Bundes-Klinik-Atlas search UI.
#' API documentation: \url{https://github.com/bundesAPI/klinikatlas-api}.
#'
#' @examples
#' \dontrun{
#' klinikatlas_ops_codes()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per OPS code.
#' @family Klinik Atlas
#' @export
klinikatlas_ops_codes <- function(safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "klinikatlas",
    "klinikatlas_ops_codes",
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  klinikatlas_tidy_records(response)
}

#' List German places from Bundes-Klinik-Atlas
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns place metadata used by the Bundes-Klinik-Atlas search UI.
#' API documentation: \url{https://github.com/bundesAPI/klinikatlas-api}.
#'
#' @examples
#' \dontrun{
#' klinikatlas_german_places()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per place entry.
#' @family Klinik Atlas
#' @export
klinikatlas_german_places <- function(safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "klinikatlas",
    "klinikatlas_german_places",
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  klinikatlas_tidy_records(response)
}

#' Search Bundes-Klinik-Atlas hospitals
#'
#' @param params Named list of upstream query parameters. Parameter names are
#'   forwarded unchanged and should match the OpenAPI spec, for example
#'   `tx_solr[searchlabel]`, `tx_solr[rows]`, or `tx_solr[icd]`.
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
#' Searches hospitals using the documented Bundes-Klinik-Atlas search endpoint.
#' Parameter names are intentionally left in the upstream bracketed form so they
#' can be passed through unchanged. API documentation:
#' \url{https://github.com/bundesAPI/klinikatlas-api}.
#'
#' @examples
#' \dontrun{
#' klinikatlas_search(params = list(
#'   "tx_solr[rows]" = 5,
#'   "tx_solr[start]" = 0,
#'   "tx_solr[searchlabel]" = "Berlin"
#' ))
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per search result and the
#' nested API payload retained in list-columns.
#' @family Klinik Atlas
#' @export
klinikatlas_search <- function(params = list(),
                               safe = TRUE,
                               refresh = FALSE,
                               flatten = FALSE,
                               flatten_mode = "json") {
  response <- bunddev_call(
    "klinikatlas",
    "klinikatlas_search",
    params = params,
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  data <- klinikatlas_tidy_search(response)
  if (flatten) {
    return(bunddev_flatten_list_cols(
      data,
      cols = c("content", "filters", "sortings", "meta_infos"),
      mode = flatten_mode
    ))
  }

  data
}

#' Fetch raw hospital detail HTML from Bundes-Klinik-Atlas
#'
#' @param id Integer hospital identifier from [klinikatlas_search()].
#' @param params Optional named list of upstream query parameters such as
#'   `tx_tverzhospitaldata_show[department]` or `cHash`.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns the upstream HTML detail page as text. This wrapper intentionally
#' avoids HTML scraping so the package remains aligned with the documented API
#' surface. API documentation: \url{https://github.com/bundesAPI/klinikatlas-api}.
#'
#' @examples
#' \dontrun{
#' html <- klinikatlas_hospital_detail(2610)
#' substr(html, 1, 200)
#' }
#'
#' @return Character scalar containing the raw HTML response.
#' @family Klinik Atlas
#' @export
klinikatlas_hospital_detail <- function(id,
                                        params = list(),
                                        safe = TRUE,
                                        refresh = FALSE) {
  params$id <- id

  bunddev_call(
    "klinikatlas",
    "klinikatlas_hospital_detail",
    params = params,
    parse = "text",
    safe = safe,
    refresh = refresh
  )
}

klinikatlas_tidy_records <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  if (!is.list(response)) {
    return(tibble::tibble(value = as.character(response)))
  }

  if (is.null(names(response)) && length(response) > 0) {
    rows <- purrr::map(response, klinikatlas_as_record)
    data <- dplyr::bind_rows(rows)
  } else {
    data <- dplyr::bind_rows(list(klinikatlas_as_record(response)))
  }

  names(data) <- vapply(names(data), klinikatlas_sanitize_name, character(1))
  data
}

klinikatlas_tidy_search <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  results <- response$results
  if (is.null(results) || length(results) == 0) {
    return(tibble::tibble())
  }

  to_chr <- function(value) {
    if (is.null(value) || length(value) == 0) NA_character_ else as.character(value)
  }
  to_int <- function(value) {
    if (is.null(value) || length(value) == 0) NA_integer_ else as.integer(value)
  }
  to_num <- function(value) {
    if (is.null(value) || length(value) == 0) NA_real_ else suppressWarnings(as.numeric(value))
  }

  tibble::tibble(
    id = purrr::map_int(results, ~ to_int(.x$id)),
    header = purrr::map_chr(results, ~ to_chr(.x$header)),
    address = purrr::map_chr(results, ~ to_chr(.x$address)),
    distance = purrr::map_dbl(results, ~ to_num(.x$distance)),
    detail_link = purrr::map_chr(results, ~ to_chr(.x$detailLink)),
    content = purrr::map(results, ~ .x$content %||% list()),
    filters = purrr::map(results, ~ .x$filters %||% list()),
    sortings = purrr::map(results, ~ .x$sortings %||% list()),
    meta_infos = purrr::map(results, ~ .x$metaInfos %||% list())
  )
}

klinikatlas_as_record <- function(x) {
  if (is.null(x)) {
    return(list())
  }

  if (!is.list(x)) {
    return(list(value = x))
  }

  purrr::modify(x, function(value) {
    if (is.null(value)) {
      return(NA)
    }
    value
  })
}

klinikatlas_sanitize_name <- function(name) {
  ascii <- iconv(name, from = "UTF-8", to = "ASCII//TRANSLIT")
  ascii <- stringr::str_replace_all(ascii, "[^A-Za-z0-9]+", "_")
  ascii <- stringr::str_replace_all(ascii, "^_+|_+$", "")
  tolower(ascii)
}
