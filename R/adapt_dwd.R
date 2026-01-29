#' Fetch DWD station overview data
#'
#' @param station_ids Station identifiers.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @return A tibble with station data.
#' @export
dwd_station_overview <- function(station_ids,
                                 safe = TRUE,
                                 refresh = FALSE,
                                 flatten = FALSE,
                                 flatten_mode = "json") {
  station_ids <- as.character(station_ids)
  response <- dwd_request(
    "station_overview",
    base_url = "https://app-prod-ws.warnwetter.de/v30",
    path = "/stationOverviewExtended",
    query = list(stationIds = paste(station_ids, collapse = ",")),
    safe = safe,
    refresh = refresh
  )

  data <- bunddev_tidy_dwd(response, operation_id = "station_overview")
  if (flatten) {
    return(bunddev_flatten_list_cols(
      data,
      cols = c("forecast1", "forecast2", "days", "warnings", "three_hour_summaries"),
      mode = flatten_mode
    ))
  }

  data
}

#' Fetch DWD crowd reports
#'
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @return A tibble with crowd reports.
#' @export
dwd_crowd_reports <- function(safe = TRUE,
                              refresh = FALSE,
                              flatten = FALSE,
                              flatten_mode = "json") {
  response <- dwd_request(
    "crowd_reports",
    base_url = "https://s3.eu-central-1.amazonaws.com/app-prod-static.warnwetter.de/v16",
    path = "/crowd_meldungen_overview_v2.json",
    safe = safe,
    refresh = refresh
  )

  data <- bunddev_tidy_dwd(response, operation_id = "crowd_reports")
  if (flatten) {
    return(bunddev_flatten_list_cols(
      data,
      cols = c("zusatz_attribute"),
      mode = flatten_mode
    ))
  }

  data
}

#' Fetch DWD nowcast warnings
#'
#' @param language Language code ("de" or "en").
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @return A tibble with nowcast warnings.
#' @export
dwd_warnings_nowcast <- function(language = c("de", "en"),
                                 safe = TRUE,
                                 refresh = FALSE,
                                 flatten = FALSE,
                                 flatten_mode = "json") {
  language <- rlang::arg_match(language)
  suffix <- if (language == "en") "_en" else ""
  response <- dwd_request(
    paste0("warnings_nowcast", suffix),
    base_url = "https://s3.eu-central-1.amazonaws.com/app-prod-static.warnwetter.de/v16",
    path = paste0("/warnings_nowcast", suffix, ".json"),
    safe = safe,
    refresh = refresh
  )

  data <- bunddev_tidy_dwd(response, operation_id = "warnings_nowcast")
  if (flatten) {
    return(bunddev_flatten_list_cols(
      data,
      cols = c("regions", "urls"),
      mode = flatten_mode
    ))
  }

  data
}

#' Fetch DWD municipality warnings
#'
#' @param language Language code ("de" or "en").
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @return A tibble with municipality warnings.
#' @export
dwd_municipality_warnings <- function(language = c("de", "en"),
                                      safe = TRUE,
                                      refresh = FALSE,
                                      flatten = FALSE,
                                      flatten_mode = "json") {
  language <- rlang::arg_match(language)
  suffix <- if (language == "en") "_en" else ""
  response <- dwd_request(
    paste0("gemeinde_warnings", suffix),
    base_url = "https://s3.eu-central-1.amazonaws.com/app-prod-static.warnwetter.de/v16",
    path = paste0("/gemeinde_warnings_v2", suffix, ".json"),
    safe = safe,
    refresh = refresh
  )

  data <- bunddev_tidy_dwd(response, operation_id = "gemeinde_warnings")
  if (flatten) {
    return(bunddev_flatten_list_cols(
      data,
      cols = c("regions", "urls"),
      mode = flatten_mode
    ))
  }

  data
}

#' Fetch DWD coastal warnings
#'
#' @param language Language code ("de" or "en").
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @return A tibble with coastal warnings.
#' @export
dwd_coast_warnings <- function(language = c("de", "en"),
                               safe = TRUE,
                               refresh = FALSE,
                               flatten = FALSE,
                               flatten_mode = "json") {
  language <- rlang::arg_match(language)
  suffix <- if (language == "en") "_en" else ""
  response <- dwd_request(
    paste0("warnings_coast", suffix),
    base_url = "https://s3.eu-central-1.amazonaws.com/app-prod-static.warnwetter.de/v16",
    path = paste0("/warnings_coast", suffix, ".json"),
    safe = safe,
    refresh = refresh
  )

  data <- bunddev_tidy_dwd(response, operation_id = "warnings_coast")
  if (flatten) {
    return(bunddev_flatten_list_cols(
      data,
      cols = c("warnings"),
      mode = flatten_mode
    ))
  }

  data
}

#' Fetch DWD sea warning text
#'
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#'
#' @return A tibble with the warning text.
#' @export
dwd_sea_warning_text <- function(safe = TRUE, refresh = FALSE) {
  response <- dwd_request(
    "sea_warning_text",
    base_url = "https://s3.eu-central-1.amazonaws.com/app-prod-static.warnwetter.de/v16",
    path = "/sea_warning_text.json",
    safe = safe,
    refresh = refresh,
    parse = "text"
  )
  tibble::tibble(text = response)
}

#' Fetch DWD alpine forecast text
#'
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#'
#' @return A tibble with the forecast text.
#' @export
dwd_alpine_forecast_text <- function(safe = TRUE, refresh = FALSE) {
  response <- dwd_request(
    "alpen_forecast_text",
    base_url = "https://s3.eu-central-1.amazonaws.com/app-prod-static.warnwetter.de/v16",
    path = "/alpen_forecast_text_dwms.json",
    safe = safe,
    refresh = refresh,
    parse = "text"
  )
  tibble::tibble(text = response)
}

#' Fetch DWD avalanche warnings
#'
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#'
#' @return A tibble with avalanche data.
#' @export
dwd_avalanche_warnings <- function(safe = TRUE, refresh = FALSE) {
  response <- dwd_request(
    "warnings_lawine",
    base_url = "https://s3.eu-central-1.amazonaws.com/app-prod-static.warnwetter.de/v16",
    path = "/warnings_lawine.json",
    safe = safe,
    refresh = refresh
  )
  bunddev_tidy_dwd(response, operation_id = "warnings_lawine")
}

bunddev_tidy_dwd <- function(response, operation_id = NULL) {
  if (operation_id == "station_overview") {
    if (is.null(response) || length(response) == 0) {
      return(tibble::tibble())
    }
    ids <- names(response)
    return(tibble::tibble(
      station_id = ids,
      forecast1 = purrr::map(response, ~ .x$forecast1 %||% list()),
      forecast2 = purrr::map(response, ~ .x$forecast2 %||% list()),
      forecast_start = purrr::map_chr(response, ~ if (is.null(.x$forecastStart)) NA_character_ else .x$forecastStart),
      days = purrr::map(response, ~ .x$days %||% list()),
      warnings = purrr::map(response, ~ .x$warnings %||% list()),
      three_hour_summaries = purrr::map(response, ~ .x$threeHourSummaries %||% list())
    ))
  }

  if (operation_id == "crowd_reports") {
    meldungen <- response$meldungen
    if (is.null(meldungen) || length(meldungen) == 0) {
      return(tibble::tibble())
    }
    chr_or_na <- function(value) {
      if (is.null(value)) NA_character_ else as.character(value)
    }
    num_or_na <- function(value) {
      if (is.null(value)) NA_real_ else as.numeric(value)
    }
    return(tibble::tibble(
      meldung_id = purrr::map_dbl(meldungen, ~ num_or_na(.x$meldungId)),
      timestamp = purrr::map_dbl(meldungen, ~ num_or_na(.x$timestamp)),
      lat = purrr::map_chr(meldungen, ~ chr_or_na(.x$lat)),
      lon = purrr::map_chr(meldungen, ~ chr_or_na(.x$lon)),
      place = purrr::map_chr(meldungen, ~ chr_or_na(.x$place)),
      category = purrr::map_chr(meldungen, ~ chr_or_na(.x$category)),
      auspraegung = purrr::map_chr(meldungen, ~ chr_or_na(.x$auspraegung)),
      zusatz_attribute = purrr::map(meldungen, ~ .x$zusatzAttribute %||% list())
    ))
  }

  if (operation_id %in% c("warnings_nowcast", "gemeinde_warnings")) {
    warnings <- response$warnings
    if (is.null(warnings) || length(warnings) == 0) {
      return(tibble::tibble())
    }
    return(tibble::tibble(
      type = purrr::map_dbl(warnings, ~ as.numeric(.x$type)),
      level = purrr::map_dbl(warnings, ~ as.numeric(.x$level)),
      start = purrr::map_dbl(warnings, ~ as.numeric(.x$start)),
      end = purrr::map_dbl(warnings, ~ as.numeric(.x$end)),
      description = purrr::map_chr(warnings, ~ as.character(.x$description)),
      description_text = purrr::map_chr(warnings, ~ as.character(.x$descriptionText)),
      event = purrr::map_chr(warnings, ~ as.character(.x$event)),
      headline = purrr::map_chr(warnings, ~ as.character(.x$headLine %||% .x$headline)),
      regions = purrr::map(warnings, ~ .x$regions %||% list()),
      urls = purrr::map(warnings, ~ .x$urls %||% list()),
      is_vorabinfo = purrr::map_lgl(warnings, ~ isTRUE(.x$isVorabinfo))
    ))
  }

  if (operation_id == "warnings_coast") {
    warnings <- response$warnings
    if (is.null(warnings) || length(warnings) == 0) {
      return(tibble::tibble())
    }
    warning_keys <- names(warnings)
    items <- purrr::flatten(warnings)
    return(tibble::tibble(
      region_id = rep_len(warning_keys, length(items)),
      type = purrr::map_dbl(items, ~ as.numeric(.x$type)),
      level = purrr::map_dbl(items, ~ as.numeric(.x$level)),
      description = purrr::map_chr(items, ~ as.character(.x$description)),
      description_text = purrr::map_chr(items, ~ as.character(.x$descriptionText)),
      event = purrr::map_chr(items, ~ as.character(.x$event)),
      headline = purrr::map_chr(items, ~ as.character(.x$headline))
    ))
  }

  if (operation_id == "warnings_lawine") {
    if (is.null(response)) {
      return(tibble::tibble())
    }
    return(tibble::tibble(raw = list(response)))
  }

  tibble::tibble()
}

dwd_request <- function(operation_id, base_url, path, query = NULL,
                        safe = TRUE, refresh = FALSE, parse = "json") {
  if (isTRUE(safe)) {
    bunddev_rate_limit_wait("dwd")
  }

  cache_path <- NULL
  if (isTRUE(safe) && parse == "json") {
    cache_path <- bunddev_response_cache_path("dwd", operation_id, query %||% list())
    if (!isTRUE(refresh) && file.exists(cache_path)) {
      raw_body <- readBin(cache_path, "raw", n = file.info(cache_path)$size)
      return(bunddev_parse_response(raw_body, parse))
    }
  }

  url <- paste0(base_url, path)
  req <- httr2::request(url)
  if (!is.null(query)) {
    req <- httr2::req_url_query(req, !!!query)
  }
  resp <- httr2::req_perform(req)
  raw_body <- httr2::resp_body_raw(resp)

  if (!is.null(cache_path)) {
    writeBin(raw_body, cache_path)
  }

  bunddev_parse_response(raw_body, parse)
}

bunddev_dwd_station_overview <- function(station_ids,
                                         safe = TRUE,
                                         refresh = FALSE,
                                         flatten = FALSE,
                                         flatten_mode = "json") {
  dwd_station_overview(
    station_ids = station_ids,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_dwd_crowd_reports <- function(safe = TRUE,
                                      refresh = FALSE,
                                      flatten = FALSE,
                                      flatten_mode = "json") {
  dwd_crowd_reports(
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_dwd_warnings_nowcast <- function(language = c("de", "en"),
                                         safe = TRUE,
                                         refresh = FALSE,
                                         flatten = FALSE,
                                         flatten_mode = "json") {
  dwd_warnings_nowcast(
    language = language,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_dwd_municipality_warnings <- function(language = c("de", "en"),
                                              safe = TRUE,
                                              refresh = FALSE,
                                              flatten = FALSE,
                                              flatten_mode = "json") {
  dwd_municipality_warnings(
    language = language,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_dwd_coast_warnings <- function(language = c("de", "en"),
                                       safe = TRUE,
                                       refresh = FALSE,
                                       flatten = FALSE,
                                       flatten_mode = "json") {
  dwd_coast_warnings(
    language = language,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_dwd_sea_warning_text <- function(safe = TRUE, refresh = FALSE) {
  dwd_sea_warning_text(safe = safe, refresh = refresh)
}

bunddev_dwd_alpine_forecast_text <- function(safe = TRUE, refresh = FALSE) {
  dwd_alpine_forecast_text(safe = safe, refresh = refresh)
}

bunddev_dwd_avalanche_warnings <- function(safe = TRUE, refresh = FALSE) {
  dwd_avalanche_warnings(safe = safe, refresh = refresh)
}
