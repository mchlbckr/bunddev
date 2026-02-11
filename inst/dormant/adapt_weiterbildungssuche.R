#' Search continuing education courses
#'
#' @param sw Search keyword.
#' @param orte Location with coordinates (format: "City_lat_lon").
#' @param uk Search radius in km (25, 50, 100, 150, 200, or "bundesweit").
#' @param page Result page number.
#' @param params Additional query parameters.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#'
#' @details
#' The Weiterbildungssuche API provides access to one of Germany's largest
#' continuing education databases from the Bundesagentur fuer Arbeit.
#' Authentication uses the public client id `infosysbub-wbsuche` as X-API-Key.
#' Official docs: https://bundesapi.github.io/weiterbildungssuche-api/.
#'
#' Common parameters include:
#' - `sys`: C = vocational, FW = advanced, empty = both
#' - `uz`: 1 = full-time, 2 = part-time
#' - `uf`: 1 = in-person, 2 = online, 3 = blended, 4 = distance
#' - `bg`: 1 = education voucher eligible
#'
#' @seealso
#' [weiterbildungssuche_facetten()] for faceted search overview.
#'
#' @examples
#' \dontrun{
#' weiterbildungssuche_search(sw = "Projektmanagement")
#' weiterbildungssuche_search(sw = "IT", orte = "Berlin_52.52_13.405", uk = 50)
#' }
#'
#' @return A tibble with course offerings.
#' @export
weiterbildungssuche_search <- function(sw = NULL,
                                       orte = NULL,
                                       uk = NULL,
                                       page = NULL,
                                       params = list(),
                                       safe = TRUE,
                                       refresh = FALSE) {
  if (!is.null(sw)) params$sw <- sw
  if (!is.null(orte)) params$orte <- orte
  if (!is.null(uk)) params$uk <- uk
  if (!is.null(page)) params$page <- page

  response <- bunddev_call(
    "weiterbildungssuche",
    "weiterbildungssuche",
    params = params,
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  weiterbildungssuche_tidy_response(response)
}

#' Get faceted overview of courses
#'
#' @param sw Search keyword.
#' @param params Additional query parameters.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#'
#' @details
#' Returns a faceted overview of available training offerings with counts
#' by category.
#'
#' @seealso
#' [weiterbildungssuche_search()] for full course search.
#'
#' @examples
#' \dontrun{
#' weiterbildungssuche_facetten(sw = "BWL")
#' }
#'
#' @return A tibble with facet data.
#' @export
weiterbildungssuche_facetten <- function(sw = NULL,
                                         params = list(),
                                         safe = TRUE,
                                         refresh = FALSE) {
  if (!is.null(sw)) params$sw <- sw

  response <- bunddev_call(
    "weiterbildungssuche",
    "facetten",
    params = params,
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  weiterbildungssuche_tidy_facetten(response)
}

weiterbildungssuche_tidy_response <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  items <- response$`_embedded`$termine %||% list()
  if (length(items) == 0) {
    return(tibble::tibble(
      total = response$page$totalElements %||% NA_integer_,
      page = response$page$number %||% NA_integer_,
      response = list(response)
    ))
  }

  to_chr <- function(value) if (is.null(value)) NA_character_ else as.character(value)
  to_int <- function(value) if (is.null(value)) NA_integer_ else as.integer(value)
  to_num <- function(value) if (is.null(value)) NA_real_ else as.numeric(value)

  tibble::tibble(
    id = purrr::map_int(items, ~ to_int(.x$id)),
    titel = purrr::map_chr(items, ~ to_chr(.x$angebot$titel %||% .x$titel)),
    anbieter = purrr::map_chr(items, ~ to_chr(.x$angebot$anbieter$name %||% NA_character_)),
    ort = purrr::map_chr(items, ~ to_chr(.x$adresse$ort %||% NA_character_)),
    beginn = purrr::map_chr(items, ~ to_chr(.x$beginn)),
    ende = purrr::map_chr(items, ~ to_chr(.x$ende)),
    dauer_value = purrr::map_int(items, ~ to_int(.x$dauer$wert %||% NA_integer_)),
    dauer_unit = purrr::map_chr(items, ~ to_chr(.x$dauer$zeiteinheit %||% NA_character_)),
    unterrichtsform = purrr::map(items, ~ .x$unterrichtsform %||% list()),
    kosten = purrr::map_chr(items, ~ to_chr(.x$kostenWert)),
    foerderung = purrr::map_lgl(items, ~ isTRUE(.x$foerderung)),
    link = purrr::map_chr(items, ~ to_chr(.x$link)),
    raw = items
  )
}

weiterbildungssuche_tidy_facetten <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  facets <- response$facetten %||% response
  if (is.list(facets) && !is.data.frame(facets)) {
    rows <- purrr::imap(facets, function(facet, name) {
      tibble::tibble(
        facet = name,
        counts = list(facet)
      )
    })
    return(dplyr::bind_rows(rows))
  }

  tibble::tibble(response = list(response))
}

bunddev_weiterbildungssuche_search <- function(sw = NULL,
                                               orte = NULL,
                                               uk = NULL,
                                               page = NULL,
                                               params = list(),
                                               safe = TRUE,
                                               refresh = FALSE) {
  weiterbildungssuche_search(
    sw = sw,
    orte = orte,
    uk = uk,
    page = page,
    params = params,
    safe = safe,
    refresh = refresh
  )
}

bunddev_weiterbildungssuche_facetten <- function(sw = NULL,
                                                 params = list(),
                                                 safe = TRUE,
                                                 refresh = FALSE) {
  weiterbildungssuche_facetten(
    sw = sw,
    params = params,
    safe = safe,
    refresh = refresh
  )
}
