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
#' **Recommended:** Configure OAuth2 via [bunddev_auth_set()] with type `"oauth2"`.
#' If you provide a client secret, it fetches an OAuth token; otherwise it falls
#' back to sending the client ID as `X-API-Key`.
#'
#' @examples
#' \dontrun{
#' # Recommended: OAuth2 configuration
#' Sys.setenv(
#'   ENTGELTATLAS_API_KEY = "c4f0d292-9d0f-4763-87dd-d3f9e78fb006",
#'   ENTGELTATLAS_CLIENT_SECRET = "<client-secret>"
#' )
#' bunddev_auth_set("entgeltatlas",
#'   type = "oauth2",
#'   oauth_url = "https://rest.arbeitsagentur.de/oauth/gettoken_cc",
#'   env_var = "ENTGELTATLAS_API_KEY",
#'   oauth_secret_env = "ENTGELTATLAS_CLIENT_SECRET",
#'   oauth_default_id = "c4f0d292-9d0f-4763-87dd-d3f9e78fb006")
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

  # OAuth2 is now handled centrally in bunddev_call()
  # Just call bunddev_call() - it automatically handles OAuth2 when configured
  bunddev_call(
    "entgeltatlas",
    path = paste0("/pc/v1/entgelte/", kldb),
    method = "GET",
    params = params,
    base_url = "https://rest.arbeitsagentur.de/infosysbub/entgeltatlas",
    parse = parse,
    safe = safe,
    refresh = refresh
  )
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
