#' Search coaching offers
#'
#' @param params Query parameters.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' The Coachingangebote API provides coaching and activation offers from the
#' Bundesagentur fuer Arbeit. Authentication can be done via OAuth2 client
#' credentials or by sending the public client id as `X-API-Key` (clientId
#' `ee971dcb-96fa-47b3-b2be-00863e4fc88b`). Official docs:
#' https://bundesapi.github.io/coachingangebote-api/.
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
#'   COACHINGANGEBOTE_API_KEY = "ee971dcb-96fa-47b3-b2be-00863e4fc88b",
#'   COACHINGANGEBOTE_CLIENT_SECRET = "<client-secret>"
#' )
#' bunddev_auth_set("coachingangebote",
#'   type = "oauth2",
#'   oauth_url = "https://rest.arbeitsagentur.de/oauth/gettoken_cc",
#'   env_var = "COACHINGANGEBOTE_API_KEY",
#'   oauth_secret_env = "COACHINGANGEBOTE_CLIENT_SECRET",
#'   oauth_default_id = "ee971dcb-96fa-47b3-b2be-00863e4fc88b")
#' coachingangebote_search(params = list(mz = "SA 01"))
#' }
#'
#' @return A tibble with coaching offers.
#'
#' Includes `gueltig_von_time`, `gueltig_bis_time`, and `aktualisierungsdatum_time` as POSIXct in Europe/Berlin.
#'
#' Use `bunddev_parameters("coachingangebote")` to see the currently valid parameters
#' if the API has changed.
#' @export
coachingangebote_search <- function(params = list(),
                                    safe = TRUE,
                                    refresh = FALSE,
                                    flatten = FALSE,
                                    flatten_mode = "json") {
  response <- coachingangebote_request(
    params = params,
    safe = safe,
    refresh = refresh
  )

  data <- coachingangebote_tidy_response(response)
  if (flatten) {
    return(bunddev_flatten_list_cols(
      data,
      cols = c("angebot", "adresse", "unterrichtsform", "ansprechpartner", "abstaende", "links", "aggregations"),
      mode = flatten_mode
    ))
  }

  data
}

coachingangebote_request <- function(params, safe = TRUE, refresh = FALSE, parse = "json") {
  # Get OAuth token using centralized auth
  token <- bunddev_oauth_token("coachingangebote")
  
  if (!is.null(token)) {
    # No secret available, fall back to API key
    client_id <- bunddev_oauth_client_id("coachingangebote")
    headers <- list(`X-API-Key` = client_id)
  } else {
    # Use OAuth token with configured header name
    headers <- list(!!setNames(list(token), bunddev_auth_get("coachingangebote")$oauth_token_header))
  }
  
  bunddev_call(
    "coachingangebote",
    "aktivierungsangebote",
    params = params,
    headers = headers,
    parse = parse,
    safe = safe,
    refresh = refresh
  )
}

coachingangebote_tidy_response <- function(response) {
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

  gueltig_von <- purrr::map_dbl(items, ~ to_num(.x$gueltigVon))
  gueltig_bis <- purrr::map_dbl(items, ~ to_num(.x$gueltigBis))
  aktualisierungsdatum <- purrr::map_dbl(items, ~ to_num(.x$aktualisierungsdatum))

  tibble::tibble(
    id = purrr::map_int(items, ~ to_int(.x$id)),
    massnahme_nummer = purrr::map_chr(items, ~ to_chr(.x$massnahmeNummer)),
    angebot = purrr::map(items, ~ .x$angebot %||% list()),
    adresse = purrr::map(items, ~ .x$adresse %||% list()),
    unterrichtsform = purrr::map(items, ~ .x$unterrichtsform %||% list()),
    gueltig_von = gueltig_von,
    gueltig_von_time = purrr::map(gueltig_von, ~ bunddev_ms_to_posix(.x)),
    gueltig_bis = gueltig_bis,
    gueltig_bis_time = purrr::map(gueltig_bis, ~ bunddev_ms_to_posix(.x)),
    massnahme_zeiten = purrr::map_chr(items, ~ to_chr(.x$massnahmeZeiten)),
    individueller_einstieg = purrr::map_lgl(items, ~ isTRUE(.x$individuellerEinstieg)),
    bemerkung_zeit = purrr::map_chr(items, ~ to_chr(.x$bemerkungZeit)),
    zusatzlink = purrr::map_chr(items, ~ to_chr(.x$zusatzlink)),
    ansprechpartner = purrr::map(items, ~ .x$ansprechpartner %||% list()),
    aktualisierungsdatum = aktualisierungsdatum,
    aktualisierungsdatum_time = purrr::map(aktualisierungsdatum, ~ bunddev_ms_to_posix(.x)),
    abstaende = purrr::map(items, ~ .x$abstaende %||% list()),
    links = list(response$`_links` %||% list()),
    aggregations = list(response$aggregations %||% list()),
    page = list(response$page %||% list())
  )
}
