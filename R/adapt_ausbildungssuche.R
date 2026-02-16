#' Search training offers
#'
#' @param params Named list of query parameters:
#'   \describe{
#'     \item{sty}{Training type filter (integer).}
#'     \item{ids}{Occupation id(s), comma-separated (integer/character).}
#'     \item{orte}{Location id(s), comma-separated (integer/character).}
#'     \item{page}{Page index, starting at `0` (integer).}
#'     \item{size}{Page size (integer, max defined by API).}
#'     \item{uk}{Radius filter, e.g. `"25"` or `"Bundesweit"` (character).}
#'     \item{re}{Region/Bundesland code (character).}
#'     \item{bart}{Training category filter (integer).}
#'     \item{ityp}{Integration type filter (integer).}
#'     \item{bt}{Start date/time window filter (integer code).}
#'     \item{ban}{Provider id(s), comma-separated (integer/character).}
#'     \item{bg}{Only entries with Bildungsgutschein support (`TRUE`/`FALSE`).}
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
#' The Ausbildungssuche API provides training offer data from the
#' Bundesagentur fuer Arbeit. Authentication is required via `X-API-Key`
#' (clientId `infosysbub-absuche`, discoverable from
#' https://web.arbeitsagentur.de/weiterbildungssuche/suche). API documentation: \url{https://bundesapi.github.io/ausbildungssuche-api/}.
#'
#' This adapter uses the `X-API-Key` header. Set it via [bunddev_auth_set()] and
#' `AUSBILDUNGSSUCHE_API_KEY`.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' [ausbildungssuche_details()] for a single offer and [bunddev_auth_set()] for
#' authentication.
#'
#' @examples
#' \dontrun{
#' Sys.setenv(AUSBILDUNGSSUCHE_API_KEY = "infosysbub-absuche")
#' bunddev_auth_set("ausbildungssuche", type = "api_key", env_var = "AUSBILDUNGSSUCHE_API_KEY")
#' ausbildungssuche_search(params = list(size = 5))
#' }
#'
#' @return A tibble with one row per training offer:
#' \describe{
#'   \item{id}{Offer id (integer).}
#'   \item{unterrichtsform}{Teaching format metadata (list-column).}
#'   \item{dauer}{Duration metadata (list-column).}
#'   \item{anbieterbewertung}{Provider rating text (character).}
#'   \item{angebot}{Offer metadata (list-column).}
#'   \item{adresse}{Address metadata (list-column).}
#'   \item{unterrichtszeiten}{Class schedule text (character).}
#'   \item{kosten_wert}{Cost value (character).}
#'   \item{kosten_waehrung}{Cost currency (character).}
#'   \item{kosten_bemerkung}{Cost note (character).}
#'   \item{foerderung}{Funding flag (`TRUE`/`FALSE`).}
#'   \item{link}{Offer link (character).}
#'   \item{bemerkung}{Additional note text (character).}
#'   \item{beginn}{Start date text (character).}
#'   \item{ende}{End date text (character).}
#'   \item{individueller_einstieg}{Flexible start flag (`TRUE`/`FALSE`).}
#'   \item{anmeldeschluss}{Registration deadline text (character).}
#'   \item{bemerkung_zeit}{Timing note (character).}
#'   \item{pruefende_stelle}{Examining body (character).}
#'   \item{eigene_angebotsnummer}{Provider's own offer id (character).}
#'   \item{teilnehmer_min}{Minimum participants (integer).}
#'   \item{teilnehmer_max}{Maximum participants (integer).}
#'   \item{aktualisierungsdatum}{Update timestamp in milliseconds (numeric).}
#'   \item{aktualisierungsdatum_time}{Update timestamp as `POSIXct` in Europe/Berlin.}
#'   \item{links}{Top-level links object (list-column).}
#'   \item{aggregations}{Aggregation metadata (list-column).}
#'   \item{page}{Paging metadata (list-column).}
#' }
#' @family Ausbildungssuche
#' @export
ausbildungssuche_search <- function(params = list(),
                                    safe = TRUE,
                                    refresh = FALSE,
                                    flatten = FALSE,
                                    flatten_mode = "json") {
  response <- bunddev_call(
    "ausbildungssuche",
    "ausbildungssuche",
    params = params,
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  data <- ausbildungssuche_tidy_response(response)
  if (flatten) {
    return(bunddev_flatten_list_cols(
      data,
      cols = c("unterrichtsform", "dauer", "angebot", "adresse", "links", "aggregations"),
      mode = flatten_mode
    ))
  }

  data
}

#' Get training offer details
#'
#' @param offer_id Offer id.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns detailed information for a single offer.
#'
#' @seealso
#' [ausbildungssuche_search()] to find offer ids.
#'
#' @examples
#' \dontrun{
#' Sys.setenv(AUSBILDUNGSSUCHE_API_KEY = "infosysbub-absuche")
#' bunddev_auth_set("ausbildungssuche", type = "api_key", env_var = "AUSBILDUNGSSUCHE_API_KEY")
#' ausbildungssuche_details(12345)
#' }
#'
#' @return A one-row tibble with:
#' \describe{
#'   \item{offer_id}{Requested offer id.}
#'   \item{data}{Raw detail payload for the offer (list-column).}
#' }
#' @family Ausbildungssuche
#' @export
ausbildungssuche_details <- function(offer_id, safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "ausbildungssuche",
    "ausbildungsdetails",
    params = list(id = offer_id),
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  tibble::tibble(offer_id = offer_id, data = list(response))
}

ausbildungssuche_tidy_response <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  items <- response$`_embedded`$termine %||% list()
  if (length(items) == 0) {
    return(tibble::tibble())
  }

  to_chr <- function(value) if (is.null(value)) NA_character_ else as.character(value)
  to_num <- function(value) if (is.null(value)) NA_real_ else as.numeric(value)
  to_int <- function(value) if (is.null(value)) NA_integer_ else as.integer(value)

  updated <- purrr::map_dbl(items, ~ to_num(.x$aktualisierungsdatum))

  tibble::tibble(
    id = purrr::map_int(items, ~ to_int(.x$id)),
    unterrichtsform = purrr::map(items, ~ .x$unterrichtsform %||% list()),
    dauer = purrr::map(items, ~ .x$dauer %||% list()),
    anbieterbewertung = purrr::map_chr(items, ~ to_chr(.x$anbieterbewertung)),
    angebot = purrr::map(items, ~ .x$angebot %||% list()),
    adresse = purrr::map(items, ~ .x$adresse %||% list()),
    unterrichtszeiten = purrr::map_chr(items, ~ to_chr(.x$unterrichtszeiten)),
    kosten_wert = purrr::map_chr(items, ~ to_chr(.x$kostenWert)),
    kosten_waehrung = purrr::map_chr(items, ~ to_chr(.x$kostenWaehrung)),
    kosten_bemerkung = purrr::map_chr(items, ~ to_chr(.x$kostenBemerkung)),
    foerderung = purrr::map_lgl(items, ~ isTRUE(.x$foerderung)),
    link = purrr::map_chr(items, ~ to_chr(.x$link)),
    bemerkung = purrr::map_chr(items, ~ to_chr(.x$bemerkung)),
    beginn = purrr::map_chr(items, ~ to_chr(.x$beginn)),
    ende = purrr::map_chr(items, ~ to_chr(.x$ende)),
    individueller_einstieg = purrr::map_lgl(items, ~ isTRUE(.x$individuellerEinstieg)),
    anmeldeschluss = purrr::map_chr(items, ~ to_chr(.x$anmeldeschluss)),
    bemerkung_zeit = purrr::map_chr(items, ~ to_chr(.x$bemerkungZeit)),
    pruefende_stelle = purrr::map_chr(items, ~ to_chr(.x$pruefendeStelle)),
    eigene_angebotsnummer = purrr::map_chr(items, ~ to_chr(.x$eigeneAngebotsnummer)),
    teilnehmer_min = purrr::map_int(items, ~ to_int(.x$teilnehmerMin)),
    teilnehmer_max = purrr::map_int(items, ~ to_int(.x$teilnehmerMax)),
    aktualisierungsdatum = updated,
    aktualisierungsdatum_time = purrr::map(updated, ~ bunddev_ms_to_posix(.x)),
    links = list(response$`_links` %||% list()),
    aggregations = list(response$aggregations %||% list()),
    page = list(response$page %||% list())
  )
}
