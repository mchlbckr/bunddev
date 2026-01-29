#' Search Jobsuche listings
#'
#' @param params Query parameters.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @return A tibble with job listings.
#'
#' Use `bunddev_parameters("jobsuche")` to see the currently valid parameters
#' if the API has changed.
#' @export
jobsuche_search <- function(params = list(),
                            safe = TRUE,
                            refresh = FALSE,
                            flatten = FALSE,
                            flatten_mode = "json") {
  response <- jobsuche_request(
    "search",
    path = "/pc/v4/jobs",
    query = params,
    safe = safe,
    refresh = refresh
  )
  jobsuche_tidy_response(response, flatten = flatten, flatten_mode = flatten_mode)
}

#' Search Jobsuche listings (app endpoint)
#'
#' @param params Query parameters.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @return A tibble with job listings.
#'
#' Use `bunddev_parameters("jobsuche")` to see the currently valid parameters
#' if the API has changed.
#' @export
jobsuche_search_app <- function(params = list(),
                                safe = TRUE,
                                refresh = FALSE,
                                flatten = FALSE,
                                flatten_mode = "json") {
  response <- jobsuche_request(
    "search_app",
    path = "/pc/v4/app/jobs",
    query = params,
    safe = safe,
    refresh = refresh
  )
  jobsuche_tidy_response(response, flatten = flatten, flatten_mode = flatten_mode)
}

#' Fetch Jobsuche employer logo
#'
#' @param hash_id Logo hash id.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#'
#' @return A tibble with raw logo bytes.
#'
#' Use `bunddev_parameters("jobsuche")` to see the currently valid parameters
#' if the API has changed.
#' @export
jobsuche_logo <- function(hash_id, safe = TRUE, refresh = FALSE) {
  response <- jobsuche_request(
    "logo",
    path = paste0("/ed/v1/arbeitgeberlogo/", hash_id),
    safe = safe,
    refresh = refresh,
    parse = "raw"
  )
  tibble::tibble(hash_id = hash_id, logo = list(response))
}

bunddev_tidy_jobsuche <- function(response, operation_id = NULL,
                                  flatten = FALSE, flatten_mode = "json") {
  jobsuche_tidy_response(response, flatten = flatten, flatten_mode = flatten_mode)
}

jobsuche_tidy_response <- function(response, flatten = FALSE, flatten_mode = "json") {
  listings <- response$stellenangebote
  if (is.null(listings) || length(listings) == 0) {
    return(tibble::tibble())
  }

  chr_or_na <- function(value) {
    if (is.null(value)) NA_character_ else as.character(value)
  }
  num_or_na <- function(value) {
    if (is.null(value)) NA_real_ else as.numeric(value)
  }

  data <- tibble::tibble(
    hash_id = purrr::map_chr(listings, ~ chr_or_na(.x$hashId)),
    beruf = purrr::map_chr(listings, ~ chr_or_na(.x$beruf)),
    refnr = purrr::map_chr(listings, ~ chr_or_na(.x$refnr)),
    arbeitgeber = purrr::map_chr(listings, ~ chr_or_na(.x$arbeitgeber)),
    aktuelle_veroeffentlichungsdatum = purrr::map_chr(
      listings,
      ~ chr_or_na(.x$aktuelleVeroeffentlichungsdatum)
    ),
    eintrittsdatum = purrr::map_chr(listings, ~ chr_or_na(.x$eintrittsdatum)),
    arbeitsort_plz = purrr::map_chr(listings, ~ chr_or_na(.x$arbeitsort$plz)),
    arbeitsort_ort = purrr::map_chr(listings, ~ chr_or_na(.x$arbeitsort$ort)),
    arbeitsort_strasse = purrr::map_chr(listings, ~ chr_or_na(.x$arbeitsort$strasse)),
    arbeitsort_region = purrr::map_chr(listings, ~ chr_or_na(.x$arbeitsort$region)),
    arbeitsort_land = purrr::map_chr(listings, ~ chr_or_na(.x$arbeitsort$land)),
    arbeitsort_lat = purrr::map_dbl(listings, ~ num_or_na(.x$arbeitsort$koordinaten$lat)),
    arbeitsort_lon = purrr::map_dbl(listings, ~ num_or_na(.x$arbeitsort$koordinaten$lon)),
    modifikations_timestamp = purrr::map_chr(listings, ~ chr_or_na(.x$modifikationsTimestamp)),
    page = chr_or_na(response$page),
    size = chr_or_na(response$size),
    max_ergebnisse = chr_or_na(response$maxErgebnisse),
    facetten = list(response$facetten %||% list())
  )

  if (flatten) {
    return(bunddev_flatten_list_cols(data, cols = c("facetten"), mode = flatten_mode))
  }

  data
}

jobsuche_request <- function(operation_id, path, query = NULL,
                             safe = TRUE, refresh = FALSE, parse = "json") {
  base_url <- "https://rest.arbeitsagentur.de/jobboerse/jobsuche-service"
  url <- paste0(base_url, path)

  if (isTRUE(safe)) {
    bunddev_rate_limit_wait("jobsuche")
  }

  cache_path <- NULL
  if (isTRUE(safe) && parse == "json") {
    cache_path <- bunddev_response_cache_path("jobsuche", operation_id, query %||% list())
    if (!isTRUE(refresh) && file.exists(cache_path)) {
      raw_body <- readBin(cache_path, "raw", n = file.info(cache_path)$size)
      return(bunddev_parse_response(raw_body, parse))
    }
  }

  req <- httr2::request(url)
  if (!is.null(query)) {
    req <- httr2::req_url_query(req, !!!query)
  }

  auth <- bunddev_auth_get("jobsuche")
  if (auth$type == "api_key") {
    if (is.na(auth$env_var) || auth$env_var == "") {
      cli::cli_abort("API key env_var is not set for 'jobsuche'.")
    }
    api_key <- Sys.getenv(auth$env_var)
    if (api_key == "") {
      cli::cli_abort("Environment variable '{auth$env_var}' is not set.")
    }
    req <- httr2::req_headers(req, "X-API-Key" = api_key)
  }

  resp <- httr2::req_perform(req)
  raw_body <- httr2::resp_body_raw(resp)

  if (!is.null(cache_path)) {
    writeBin(raw_body, cache_path)
  }

  bunddev_parse_response(raw_body, parse)
}

bunddev_jobsuche_search <- function(params = list(),
                                    safe = TRUE,
                                    refresh = FALSE,
                                    flatten = FALSE,
                                    flatten_mode = "json") {
  jobsuche_search(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_jobsuche_search_app <- function(params = list(),
                                        safe = TRUE,
                                        refresh = FALSE,
                                        flatten = FALSE,
                                        flatten_mode = "json") {
  jobsuche_search_app(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_jobsuche_logo <- function(hash_id, safe = TRUE, refresh = FALSE) {
  jobsuche_logo(hash_id = hash_id, safe = safe, refresh = refresh)
}
