#' Query Entgeltatlas data by KldB key
#'
#' @param kldb KldB 2010 key (3-5 digits).
#' @param params Query parameters.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' The Entgeltatlas API provides wage statistics for occupational categories
#' identified by KldB keys. The API accepts optional filters for region, gender,
#' age, sector, and performance level. Official docs:
#' https://bundesapi.github.io/entgeltatlas-api/.
#'
#' Authentication can be done via OAuth2 client credentials or by sending the
#' public client id as `X-API-Key`. Set the client id via [bunddev_auth_set()]
#' (env var name `ENTGELTATLAS_API_KEY`). If you also set
#' `ENTGELTATLAS_CLIENT_SECRET`, the adapter requests an OAuth token from
#' `https://rest.arbeitsagentur.de/oauth/gettoken_cc` and sends it as
#' `OAuthAccessToken`.
#'
#' @examples
#' \dontrun{
#' Sys.setenv(
#'   ENTGELTATLAS_API_KEY = "c4f0d292-9d0f-4763-87dd-d3f9e78fb006",
#'   ENTGELTATLAS_CLIENT_SECRET = "<client-secret>"
#' )
#' entgeltatlas_entgelte("84304", params = list(r = 1, g = 1))
#' }
#'
#' @return A tibble with entgelt entries.
#'
#' Use `bunddev_parameters("entgeltatlas")` to see the currently valid
#' parameters if the API has changed.
#' @export
entgeltatlas_entgelte <- function(kldb,
                                  params = list(),
                                  safe = TRUE,
                                  refresh = FALSE,
                                  flatten = FALSE,
                                  flatten_mode = "json") {
  response <- entgeltatlas_request(
    kldb = kldb,
    params = params,
    safe = safe,
    refresh = refresh
  )

  data <- entgeltatlas_tidy_entgelte(response)
  if (flatten) {
    return(bunddev_flatten_list_cols(
      data,
      cols = c("region", "gender", "age_category", "performance_level", "branche"),
      mode = flatten_mode
    ))
  }

  data
}

entgeltatlas_request <- function(kldb,
                                 params = list(),
                                 safe = TRUE,
                                 refresh = FALSE,
                                 parse = "json") {
  if (is.null(kldb) || kldb == "") {
    cli::cli_abort("kldb is required.")
  }

  spec <- tryCatch(
    bunddev_spec("entgeltatlas"),
    error = function(e) NULL
  )
  base_url <- "https://rest.arbeitsagentur.de/infosysbub/entgeltatlas"
  if (!is.null(spec) && !is.null(spec$servers) && length(spec$servers) > 0) {
    base_url <- spec$servers[[1]]$url %||% base_url
  }
  url <- paste0(stringr::str_remove(base_url, "/$"), "/pc/v1/entgelte/", kldb)

  if (isTRUE(safe)) {
    bunddev_rate_limit_wait("entgeltatlas")
  }

  cache_path <- NULL
  if (isTRUE(safe)) {
    cache_path <- bunddev_response_cache_path("entgeltatlas", "entgelte", c(list(kldb = kldb), params))
    if (!isTRUE(refresh) && file.exists(cache_path)) {
      raw_body <- readBin(cache_path, "raw", n = file.info(cache_path)$size)
      return(bunddev_parse_response(raw_body, parse))
    }
  }

  req <- httr2::request(url)
  if (length(params) > 0) {
    req <- httr2::req_url_query(req, !!!params)
  }

  client_id <- entgeltatlas_client_id()
  token <- entgeltatlas_oauth_token(client_id)
  if (!is.null(token)) {
    req <- httr2::req_headers(req, OAuthAccessToken = token)
  } else {
    req <- httr2::req_headers(req, `X-API-Key` = client_id)
  }

  resp <- httr2::req_perform(req)
  raw_body <- httr2::resp_body_raw(resp)

  if (!is.null(cache_path)) {
    writeBin(raw_body, cache_path)
  }

  bunddev_parse_response(raw_body, parse)
}

entgeltatlas_client_id <- function() {
  default_id <- "c4f0d292-9d0f-4763-87dd-d3f9e78fb006"
  auth <- bunddev_auth_get("entgeltatlas")
  if (auth$type == "api_key") {
    client_id <- Sys.getenv(auth$env_var)
    if (client_id == "") {
      cli::cli_abort("Environment variable '{auth$env_var}' is not set.")
    }
    return(client_id)
  }

  env_id <- Sys.getenv("ENTGELTATLAS_API_KEY")
  if (env_id != "") {
    return(env_id)
  }

  default_id
}

entgeltatlas_oauth_token <- function(client_id) {
  client_secret <- Sys.getenv("ENTGELTATLAS_CLIENT_SECRET")
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

entgeltatlas_tidy_entgelte <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  to_chr <- function(value) {
    if (is.null(value)) NA_character_ else as.character(value)
  }
  to_int <- function(value) {
    if (is.null(value)) NA_integer_ else as.integer(value)
  }

  tibble::tibble(
    kldb = purrr::map_chr(response, ~ to_chr(.x$kldb)),
    region = purrr::map(response, ~ .x$region %||% list()),
    gender = purrr::map(response, ~ .x$gender %||% list()),
    age_category = purrr::map(response, ~ .x$ageCategory %||% list()),
    performance_level = purrr::map(response, ~ .x$performanceLevel %||% list()),
    branche = purrr::map(response, ~ .x$branche %||% list()),
    entgelt = purrr::map_int(response, ~ to_int(.x$entgelt)),
    entgelt_q25 = purrr::map_int(response, ~ to_int(.x$entgeltQ25)),
    entgelt_q75 = purrr::map_int(response, ~ to_int(.x$entgeltQ75)),
    besetzung = purrr::map_int(response, ~ to_int(.x$besetzung))
  )
}

bunddev_entgeltatlas_entgelte <- function(kldb,
                                          params = list(),
                                          safe = TRUE,
                                          refresh = FALSE,
                                          flatten = FALSE,
                                          flatten_mode = "json") {
  entgeltatlas_entgelte(
    kldb = kldb,
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}
