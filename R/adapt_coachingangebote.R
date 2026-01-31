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
#' This adapter uses the `X-API-Key` header by default. Set it via
#' [bunddev_auth_set()] and `COACHINGANGEBOTE_API_KEY`. If you also set
#' `COACHINGANGEBOTE_CLIENT_SECRET`, the adapter requests an OAuth token from
#' `https://rest.arbeitsagentur.de/oauth/gettoken_cc` and sends it as
#' `OAuthAccessToken`.
#'
#' @seealso
#' [bunddev_auth_set()] to configure authentication.
#'
#' @examples
#' \dontrun{
#' Sys.setenv(
#'   COACHINGANGEBOTE_API_KEY = "ee971dcb-96fa-47b3-b2be-00863e4fc88b",
#'   COACHINGANGEBOTE_CLIENT_SECRET = "<client-secret>"
#' )
#' bunddev_auth_set("coachingangebote", type = "api_key", env_var = "COACHINGANGEBOTE_API_KEY")
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
  # Get client ID and optionally fetch OAuth token
  client_id <- coachingangebote_client_id()
  token <- coachingangebote_oauth_token(client_id)

  # Use appropriate auth header based on whether we have an OAuth token
  if (!is.null(token)) {
    headers <- list(OAuthAccessToken = token)
  } else {
    headers <- list(`X-API-Key` = client_id)
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

coachingangebote_client_id <- function() {
  default_id <- "ee971dcb-96fa-47b3-b2be-00863e4fc88b"
  auth <- bunddev_auth_get("coachingangebote")
  if (auth$type == "api_key") {
    client_id <- Sys.getenv(auth$env_var)
    if (client_id == "") {
      cli::cli_abort("Environment variable '{auth$env_var}' is not set.")
    }
    return(client_id)
  }

  env_id <- Sys.getenv("COACHINGANGEBOTE_API_KEY")
  if (env_id != "") {
    return(env_id)
  }

  default_id
}

coachingangebote_oauth_token <- function(client_id) {
  client_secret <- Sys.getenv("COACHINGANGEBOTE_CLIENT_SECRET")
  if (client_secret == "") {
    return(NULL)
  }

  resp <- tryCatch({
    httr2::request("https://rest.arbeitsagentur.de/oauth/gettoken_cc") |>
      httr2::req_method("POST") |>
      httr2::req_body_form(
        client_id = client_id,
        client_secret = client_secret,
        grant_type = "client_credentials"
      ) |>
      httr2::req_perform()
  }, error = function(e) NULL)

  if (is.null(resp)) {
    return(NULL)
  }

  raw_body <- httr2::resp_body_raw(resp)
  text <- rawToChar(raw_body)

  if (jsonlite::validate(text)) {
    parsed <- jsonlite::fromJSON(text)
    token <- parsed$access_token %||% parsed$token
    if (!is.null(token) && token != "") {
      return(token)
    }
  }

  token <- stringr::str_extract(text, "[A-Za-z0-9-_]{200,}")
  if (!is.na(token) && token != "") {
    return(token)
  }

  NULL
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
