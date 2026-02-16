#' Search Jobsuche listings
#'
#' @param params Named list of query parameters:
#'   \describe{
#'     \item{was}{Free-text job/keyword query (character).}
#'     \item{wo}{Location query (character).}
#'     \item{berufsfeld}{Occupational field filter (character).}
#'     \item{page}{Page index (integer).}
#'     \item{size}{Number of results per page (integer).}
#'     \item{arbeitgeber}{Employer filter (character).}
#'     \item{veroeffentlichtseit}{Only offers published within N days (integer).}
#'     \item{zeitarbeit}{Filter temporary-agency postings (`TRUE`/`FALSE`).}
#'     \item{angebotsart}{Offer type code(s), semicolon-separated (integer/character).}
#'     \item{befristung}{Contract duration code(s), semicolon-separated (integer/character).}
#'     \item{arbeitszeit}{Work time model code(s), semicolon-separated (character).}
#'     \item{behinderung}{Accessibility/disability filter (`TRUE`/`FALSE`).}
#'     \item{corona}{Only postings with corona flag (`TRUE`/`FALSE`).}
#'     \item{umkreis}{Radius in kilometers around `wo` (integer).}
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
#' The Jobsuche API provides access to job listings from the Bundesagentur fuer
#' Arbeit. Authentication is required via an API key passed as `X-API-Key`.
#' See https://jobsuche.api.bund.dev for the official API documentation.
#'
#' Use [bunddev_auth_set()] to configure the key and [bunddev_parameters()] to
#' discover supported query parameters.
#'
#' @seealso
#' [jobsuche_search_app()] for the app endpoint, [jobsuche_logo()] to fetch
#' employer logos, and [bunddev_auth_set()] for authentication.
#'
#' @examples
#' \dontrun{
#' Sys.setenv(JOBBOERSE_API_KEY = "jobboerse-jobsuche")
#' bunddev_auth_set("jobsuche", type = "api_key", env_var = "JOBBOERSE_API_KEY")
#' jobsuche_search(params = list(was = "data", size = 5), flatten = TRUE)
#' }
#'
#' @return A tibble with one row per job listing:
#' \describe{
#'   \item{hash_id}{Posting hash id (character).}
#'   \item{beruf}{Job title/occupation (character).}
#'   \item{refnr}{Reference number (character).}
#'   \item{arbeitgeber}{Employer name (character).}
#'   \item{aktuelle_veroeffentlichungsdatum}{Published date/time text (character).}
#'   \item{aktuelle_veroeffentlichungsdatum_time}{Published timestamp as `POSIXct` in Europe/Berlin.}
#'   \item{eintrittsdatum}{Start date text (character).}
#'   \item{eintrittsdatum_time}{Start timestamp as `POSIXct` in Europe/Berlin.}
#'   \item{arbeitsort_plz}{Postal code (character).}
#'   \item{arbeitsort_ort}{City/locality (character).}
#'   \item{arbeitsort_strasse}{Street (character).}
#'   \item{arbeitsort_region}{Region/state (character).}
#'   \item{arbeitsort_land}{Country code/name (character).}
#'   \item{arbeitsort_lat}{Latitude (numeric).}
#'   \item{arbeitsort_lon}{Longitude (numeric).}
#'   \item{modifikations_timestamp}{Modification timestamp text (character).}
#'   \item{modifikations_timestamp_time}{Modification timestamp as `POSIXct` in Europe/Berlin.}
#'   \item{page}{Returned page number (character).}
#'   \item{size}{Returned page size (character).}
#'   \item{max_ergebnisse}{Total result count (character).}
#'   \item{facetten}{Facet metadata (list-column).}
#' }
#' @family Jobsuche
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
#' @inheritParams jobsuche_search
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
#' This uses the mobile app endpoint of the Jobsuche API. It shares the same
#' authentication mechanism and parameters as [jobsuche_search()].
#'
#' See https://jobsuche.api.bund.dev for API documentation.
#'
#' @seealso
#' [jobsuche_search()] for the standard endpoint and [bunddev_parameters()] for
#' parameter discovery.
#'
#' @examples
#' \dontrun{
#' Sys.setenv(JOBBOERSE_API_KEY = "jobboerse-jobsuche")
#' bunddev_auth_set("jobsuche", type = "api_key", env_var = "JOBBOERSE_API_KEY")
#' jobsuche_search_app(params = list(was = "data", size = 5), flatten = TRUE)
#' }
#'
#' @return A tibble with the same columns as [jobsuche_search()].
#' \describe{
#'   \item{hash_id}{Posting hash id (character).}
#'   \item{beruf}{Job title/occupation (character).}
#'   \item{refnr}{Reference number (character).}
#'   \item{arbeitgeber}{Employer name (character).}
#'   \item{aktuelle_veroeffentlichungsdatum}{Published date/time text (character).}
#'   \item{aktuelle_veroeffentlichungsdatum_time}{Published timestamp as `POSIXct` (Europe/Berlin).}
#'   \item{eintrittsdatum}{Start date text (character).}
#'   \item{eintrittsdatum_time}{Start timestamp as `POSIXct` (Europe/Berlin).}
#'   \item{arbeitsort_plz}{Postal code (character).}
#'   \item{arbeitsort_ort}{City/locality (character).}
#'   \item{arbeitsort_strasse}{Street (character).}
#'   \item{arbeitsort_region}{Region/state (character).}
#'   \item{arbeitsort_land}{Country code/name (character).}
#'   \item{arbeitsort_lat}{Latitude (numeric).}
#'   \item{arbeitsort_lon}{Longitude (numeric).}
#'   \item{modifikations_timestamp}{Modification timestamp text (character).}
#'   \item{modifikations_timestamp_time}{Modification timestamp as `POSIXct` (Europe/Berlin).}
#'   \item{page}{Returned page number (character).}
#'   \item{size}{Returned page size (character).}
#'   \item{max_ergebnisse}{Total result count (character).}
#'   \item{facetten}{Facet metadata (list-column).}
#' }
#' @family Jobsuche
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
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns the raw logo bytes for a given employer hash id. Use this together
#' with listings returned by [jobsuche_search()] or [jobsuche_search_app()].
#'
#' See https://jobsuche.api.bund.dev for API documentation.
#'
#' @seealso
#' [jobsuche_search()] for listings and [bunddev_auth_set()] for auth setup.
#'
#' @examples
#' \dontrun{
#' Sys.setenv(JOBBOERSE_API_KEY = "jobboerse-jobsuche")
#' bunddev_auth_set("jobsuche", type = "api_key", env_var = "JOBBOERSE_API_KEY")
#' logo <- jobsuche_logo("abc123")
#' }
#'
#' @return A one-row tibble with:
#' \describe{
#'   \item{hash_id}{Requested logo hash id (character).}
#'   \item{logo}{Raw logo bytes (list-column with raw vector).}
#' }
#' @family Jobsuche
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

  parse_time <- function(value, tz = "Europe/Berlin") {
    if (is.null(value)) {
      return(as.POSIXct(NA_real_, origin = "1970-01-01", tz = tz))
    }
    if (inherits(value, "POSIXct")) {
      return(value)
    }
    if (inherits(value, "Date")) {
      return(as.POSIXct(value, tz = tz))
    }
    if (is.numeric(value)) {
      return(bunddev_ms_to_posix(value, tz = tz))
    }
    if (is.character(value) && grepl("^\\d{12,}$", value)) {
      return(bunddev_ms_to_posix(value, tz = tz))
    }
    suppressWarnings(as.POSIXct(value, tz = tz))
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
    aktuelle_veroeffentlichungsdatum_time = purrr::map(
      listings,
      ~ parse_time(.x$aktuelleVeroeffentlichungsdatum)
    ),
    eintrittsdatum = purrr::map_chr(listings, ~ chr_or_na(.x$eintrittsdatum)),
    eintrittsdatum_time = purrr::map(listings, ~ parse_time(.x$eintrittsdatum)),
    arbeitsort_plz = purrr::map_chr(listings, ~ chr_or_na(.x$arbeitsort$plz)),
    arbeitsort_ort = purrr::map_chr(listings, ~ chr_or_na(.x$arbeitsort$ort)),
    arbeitsort_strasse = purrr::map_chr(listings, ~ chr_or_na(.x$arbeitsort$strasse)),
    arbeitsort_region = purrr::map_chr(listings, ~ chr_or_na(.x$arbeitsort$region)),
    arbeitsort_land = purrr::map_chr(listings, ~ chr_or_na(.x$arbeitsort$land)),
    arbeitsort_lat = purrr::map_dbl(listings, ~ num_or_na(.x$arbeitsort$koordinaten$lat)),
    arbeitsort_lon = purrr::map_dbl(listings, ~ num_or_na(.x$arbeitsort$koordinaten$lon)),
    modifikations_timestamp = purrr::map_chr(listings, ~ chr_or_na(.x$modifikationsTimestamp)),
    modifikations_timestamp_time = purrr::map(listings, ~ parse_time(.x$modifikationsTimestamp)),
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
  bunddev_call(
    "jobsuche",
    path = path,
    method = "GET",
    params = query,
    base_url = "https://rest.arbeitsagentur.de/jobboerse/jobsuche-service",
    parse = parse,
    safe = safe,
    refresh = refresh
  )
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
