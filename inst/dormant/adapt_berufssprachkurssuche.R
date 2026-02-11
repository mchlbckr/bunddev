#' Search language course offers
#'
#' @param params Query parameters.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' The Berufssprachkurssuche API provides language course data. Authentication
#' can be done via OAuth2 client credentials or by sending the public client id
#' as `X-API-Key` (clientId `bd24f42e-ad0b-4005-b834-23bb6800dc6c`). Official
#' docs: https://berufssprachkurssuche.api.bund.dev/.
#'
#' **Recommended:** Configure OAuth2 via [bunddev_auth_set()] with type `"oauth2"`.
#' If you provide a client secret, it fetches an OAuth token; otherwise it falls
#' back to sending the client ID as `X-API-Key`.
#'
#' @seealso
#' [bunddev_auth_set()] to configure authentication.
#'
#' @examples
#' \dontrun{
#' # Recommended: OAuth2 configuration
#' Sys.setenv(
#'   BERUFSSPRACHKURSSUCHE_API_KEY = "bd24f42e-ad0b-4005-b834-23bb6800dc6c",
#'   BERUFSSPRACHKURSSUCHE_CLIENT_SECRET = "<client-secret>"
#' )
#' bunddev_auth_set("berufssprachkurssuche",
#'   type = "oauth2",
#'   oauth_url = "https://rest.arbeitsagentur.de/oauth/gettoken_cc",
#'   env_var = "BERUFSSPRACHKURSSUCHE_API_KEY",
#'   oauth_secret_env = "BERUFSSPRACHKURSSUCHE_CLIENT_SECRET",
#'   oauth_default_id = "bd24f42e-ad0b-4005-b834-23bb6800dc6c")
#' berufssprachkurssuche_search(params = list(page = 0, systematiken = "MC"))
#' }
#'
#' @return A tibble with course offers.
#'
#' Includes `beginn_time`, `ende_time`, and `anmeldeschluss_time` as POSIXct in Europe/Berlin.
#' @export
berufssprachkurssuche_search <- function(params = list(),
                                         safe = TRUE,
                                         refresh = FALSE,
                                         flatten = FALSE,
                                         flatten_mode = "json") {
  response <- berufssprachkurssuche_request(
    params = params,
    safe = safe,
    refresh = refresh
  )

  data <- berufssprachkurssuche_tidy_response(response)
  if (flatten) {
    return(bunddev_flatten_list_cols(
      data,
      cols = c("unterrichtsform", "dauer", "angebot", "adresse", "links", "aggregations", "veranstaltungsablaeufe", "abstaende"),
      mode = flatten_mode
    ))
  }

  data
}

berufssprachkurssuche_request <- function(params, safe = TRUE, refresh = FALSE, parse = "json") {
  # OAuth2 is now handled centrally in bunddev_call()
  # Just call bunddev_call() - it automatically handles OAuth2 when configured
  bunddev_call(
    "berufssprachkurssuche",
    "berufssprachkurssuche",
    params = params,
    parse = parse,
    safe = safe,
    refresh = refresh
  )
}

berufssprachkurssuche_tidy_response <- function(response) {
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

  beginn <- purrr::map_dbl(items, ~ to_num(.x$beginn))
  ende <- purrr::map_dbl(items, ~ to_num(.x$ende))
  anmeldeschluss <- purrr::map_dbl(items, ~ to_num(.x$anmeldeschluss))
  aktualisierungsdatum <- purrr::map_dbl(items, ~ to_num(.x$aktualisierungsdatum))

  tibble::tibble(
    id = purrr::map_int(items, ~ to_int(.x$id)),
    unterrichtsform = purrr::map(items, ~ .x$unterrichtsform %||% list()),
    dauer = purrr::map(items, ~ .x$dauer %||% list()),
    foerderung = purrr::map_lgl(items, ~ isTRUE(.x$foerderung)),
    kosten_wert = purrr::map_chr(items, ~ to_chr(.x$kostenWert)),
    kosten_waehrung = purrr::map_chr(items, ~ to_chr(.x$kostenWaehrung)),
    beginn = beginn,
    beginn_time = purrr::map(beginn, ~ bunddev_ms_to_posix(.x)),
    ende = ende,
    ende_time = purrr::map(ende, ~ bunddev_ms_to_posix(.x)),
    anmeldeschluss = anmeldeschluss,
    anmeldeschluss_time = purrr::map(anmeldeschluss, ~ bunddev_ms_to_posix(.x)),
    kosten_bemerkung = purrr::map_chr(items, ~ to_chr(.x$kostenBemerkung)),
    teilnehmer_min = purrr::map_int(items, ~ to_int(.x$teilnehmerMin)),
    teilnehmer_max = purrr::map_int(items, ~ to_int(.x$teilnehmerMax)),
    aktualisierungsdatum = aktualisierungsdatum,
    aktualisierungsdatum_time = purrr::map(aktualisierungsdatum, ~ bunddev_ms_to_posix(.x)),
    bemerkung = purrr::map_chr(items, ~ to_chr(.x$bemerkung)),
    link = purrr::map_chr(items, ~ to_chr(.x$link)),
    individueller_einstieg = purrr::map_lgl(items, ~ isTRUE(.x$individuellerEinstieg)),
    unterrichtszeiten = purrr::map_chr(items, ~ to_chr(.x$unterrichtszeiten)),
    bemerkung_zeit = purrr::map_chr(items, ~ to_chr(.x$bemerkungZeit)),
    eigene_angebotsnummer = purrr::map_chr(items, ~ to_chr(.x$eigeneAngebotsnummer)),
    pruefende_stelle = purrr::map_chr(items, ~ to_chr(.x$pruefendeStelle)),
    angebot = purrr::map(items, ~ .x$angebot %||% list()),
    veranstaltungsablaeufe = purrr::map(items, ~ .x$veranstaltungsablaeufe %||% list()),
    adresse = purrr::map(items, ~ .x$adresse %||% list()),
    azubi_geeignet = purrr::map_lgl(items, ~ isTRUE(.x$azubiGeeignet)),
    ansprechpartner = purrr::map(items, ~ .x$ansprechpartner %||% list()),
    abstaende = purrr::map(items, ~ .x$abstaende %||% list()),
    links = list(response$`_links` %||% list()),
    aggregations = list(response$aggregations %||% list()),
    page = list(response$page %||% list())
  )
}
