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
  response <- klinikatlas_request(
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
  response <- klinikatlas_request(
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
  response <- klinikatlas_request(
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
  response <- klinikatlas_request(
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
  response <- klinikatlas_request(
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
  response <- klinikatlas_request(
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
  response <- klinikatlas_request(
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
#' @param raw Logical; if `TRUE`, return the upstream HTML detail page as a
#'   character scalar. Default `FALSE` returns a one-row tibble with extracted
#'   summary fields.
#'
#' @details
#' The public Klinik-Atlas detail endpoint currently serves HTML. By default
#' this helper extracts a one-row summary tibble with contact details and a few
#' headline metrics from the page. Set `raw = TRUE` to retrieve the original
#' HTML response instead. API documentation:
#' \url{https://github.com/bundesAPI/klinikatlas-api}.
#'
#' @examples
#' \dontrun{
#' klinikatlas_hospital_detail(2610)
#' }
#'
#' @return A one-row [tibble][tibble::tibble] with extracted hospital detail
#'   fields, or a character scalar containing the raw HTML response when
#'   `raw = TRUE`.
#' @family Klinik Atlas
#' @export
klinikatlas_hospital_detail <- function(id,
                                        params = list(),
                                        safe = TRUE,
                                        refresh = FALSE,
                                        raw = FALSE) {
  params$id <- id

  html <- klinikatlas_request(
    "klinikatlas_hospital_detail",
    params = params,
    parse = "text",
    safe = safe,
    refresh = refresh
  )

  if (isTRUE(raw)) {
    return(html)
  }

  klinikatlas_tidy_detail(html, id = id)
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

klinikatlas_request <- function(operation_id,
                                params = list(),
                                parse = c("json", "text"),
                                safe = TRUE,
                                refresh = FALSE) {
  parse <- rlang::arg_match(parse)

  bunddev_call(
    "klinikatlas",
    operation_id,
    params = params,
    parse = parse,
    base_url = "https://bundes-klinik-atlas.de",
    safe = safe,
    refresh = refresh
  )
}

klinikatlas_tidy_detail <- function(html, id) {
  doc <- xml2::read_html(html)

  text_squish <- function(x) {
    stringr::str_squish(gsub("\u00a0", " ", x, fixed = TRUE))
  }

  attr_text <- function(node, attr) {
    value <- xml2::xml_attr(node, attr)
    if (is.na(value) || identical(value, "")) NA_character_ else value
  }

  node_text <- function(node) {
    if (inherits(node, "xml_missing") || length(node) == 0) {
      return(NA_character_)
    }

    value <- text_squish(xml2::xml_text(node))
    if (identical(value, "")) NA_character_ else value
  }

  parse_number <- function(x) {
    if (is.na(x) || identical(x, "")) {
      return(NA_real_)
    }

    normalized <- stringr::str_replace_all(x, "\\.", "")
    normalized <- stringr::str_replace_all(normalized, ",", ".")
    normalized <- stringr::str_extract(normalized, "-?[0-9]+(?:\\.[0-9]+)?")
    suppressWarnings(as.numeric(normalized))
  }

  parse_integer <- function(x) {
    value <- parse_number(x)
    if (is.na(value)) NA_integer_ else as.integer(round(value))
  }

  list_text <- function(xpath) {
    nodes <- xml2::xml_find_all(doc, xpath)
    values <- text_squish(xml2::xml_text(nodes))
    values[nzchar(values)]
  }

  top_info <- xml2::xml_find_first(doc, ".//div[contains(@class, 'c-hospital-map__info')]")
  map_node <- xml2::xml_find_first(doc, ".//div[@id = 'js_hospital-map']")

  latlng <- attr_text(map_node, "data-location-latlng")
  lat <- NA_real_
  lon <- NA_real_
  if (!is.na(latlng)) {
    parts <- stringr::str_split(latlng, ",\\s*", simplify = TRUE)
    if (ncol(parts) >= 2) {
      lat <- suppressWarnings(as.numeric(parts[1]))
      lon <- suppressWarnings(as.numeric(parts[2]))
    }
  }

  ownership_item <- xml2::xml_find_first(top_info, ".//li[.//strong[contains(normalize-space(.), 'Träger:')]]")
  ownership <- list_text(".//div[contains(@class, 'c-hospital-map__info')]//li[.//strong[contains(normalize-space(.), 'Träger:')]]/text()")
  ownership <- ownership[nzchar(ownership)]
  ownership <- if (length(ownership) == 0) NA_character_ else ownership[[1]]

  size_small <- node_text(xml2::xml_find_first(top_info, ".//li[contains(@class, 'location-size')]//small"))
  beds <- parse_integer(size_small)
  size_category <- stringr::str_match(size_small %||% "", "\\(([^)]+)\\)")[, 2]
  if (identical(size_category, "")) {
    size_category <- NA_character_
  }

  website_node <- xml2::xml_find_first(top_info, ".//a[starts-with(@href, 'http')]")
  phone_node <- xml2::xml_find_first(top_info, ".//a[starts-with(@href, 'tel:')]")
  email_node <- xml2::xml_find_first(top_info, ".//a[starts-with(@href, 'mailto:')]")

  cases_header <- xml2::xml_find_first(doc, ".//div[@id = 'content-menu-cases']")
  case_text_node <- xml2::xml_find_first(cases_header, ".//div[contains(@class, 'c-tacho-text__text')]")
  case_text <- node_text(case_text_node)
  case_count <- parse_integer(case_text)
  case_count_category <- stringr::str_match(case_text %||% "", "\\(([^)]+)\\)")[, 2]
  if (identical(case_count_category, "")) {
    case_count_category <- NA_character_
  }

  nursing_header <- xml2::xml_find_first(doc, ".//div[@id = 'content-menu-stuff']")
  nursing_text <- node_text(xml2::xml_find_first(nursing_header, ".//div[contains(@class, 'c-tacho-text__text')]"))
  nursing_quotient <- parse_number(nursing_text)
  nursing_quotient_category <- stringr::str_match(nursing_text %||% "", "\\(([^)]+)\\)")[, 2]
  if (identical(nursing_quotient_category, "")) {
    nursing_quotient_category <- NA_character_
  }

  nursing_staff_text <- node_text(xml2::xml_find_first(
    nursing_header,
    ".//p[contains(., 'Pflegekräfte in der unmittelbaren Patientenversorgung')]"
  ))
  nursing_staff_direct_care <- parse_integer(nursing_staff_text)

  departments_header <- xml2::xml_find_first(doc, ".//div[@id = 'content-menu-departments']")
  department_count_text <- node_text(xml2::xml_find_first(
    departments_header,
    ".//div[contains(@class, 'ce-accordion__header__hidden-components')]//strong"
  ))
  department_count <- parse_integer(department_count_text)
  departments <- list_text(
    ".//div[@id = 'accordion-2-panel-2']//ul[contains(@class, 'rte_ul')]/li"
  )

  tibble::tibble(
    id = as.integer(id),
    name = node_text(xml2::xml_find_first(doc, ".//h1")),
    address = node_text(xml2::xml_find_first(top_info, ".//address")),
    latitude = lat,
    longitude = lon,
    website = attr_text(website_node, "href"),
    phone = node_text(phone_node),
    email = node_text(email_node),
    ownership = ownership,
    beds = beds,
    size_category = size_category,
    case_count = case_count,
    case_count_category = case_count_category,
    nursing_quotient = nursing_quotient,
    nursing_quotient_category = nursing_quotient_category,
    nursing_staff_direct_care = nursing_staff_direct_care,
    department_count = department_count,
    departments = list(departments)
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
