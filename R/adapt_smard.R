#' List available SMARD timestamps
#'
#' @param filter Filter id.
#' @param region Region code.
#' @param resolution Data resolution.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#'
#' @return A tibble of timestamps.
#' @export
smard_indices <- function(filter, region = "DE", resolution = "hour", safe = TRUE, refresh = FALSE) {
  path <- sprintf("/chart_data/%s/%s/index_%s.json", filter, region, resolution)
  response <- smard_request("indices", path, params = list(
    filter = filter,
    region = region,
    resolution = resolution
  ), safe = safe, refresh = refresh)
  bunddev_tidy_smard(response, operation_id = "indices")
}

#' Fetch SMARD timeseries data
#'
#' @param filter Filter id.
#' @param region Region code.
#' @param resolution Data resolution.
#' @param timestamp Timestamp from indices.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#'
#' @return A tibble of time series values.
#' @export
smard_timeseries <- function(filter, region = "DE", resolution = "hour", timestamp,
                             safe = TRUE, refresh = FALSE) {
  path <- sprintf(
    "/chart_data/%s/%s/%s_%s_%s_%s.json",
    filter,
    region,
    filter,
    region,
    resolution,
    timestamp
  )
  response <- smard_request("timeseries", path, params = list(
    filter = filter,
    filterCopy = filter,
    region = region,
    regionCopy = region,
    resolution = resolution,
    timestamp = timestamp
  ), safe = safe, refresh = refresh)
  bunddev_tidy_smard(response, operation_id = "timeseries")
}

#' Fetch SMARD table data
#'
#' @param filter Filter id.
#' @param region Region code.
#' @param timestamp Timestamp from indices.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#'
#' @return A tibble of table values.
#' @export
smard_table <- function(filter, region = "DE", timestamp, safe = TRUE, refresh = FALSE) {
  path <- sprintf(
    "/table_data/%s/%s/%s_%s_quarterhour_%s.json",
    filter,
    region,
    filter,
    region,
    timestamp
  )
  response <- smard_request("table", path, params = list(
    filter = filter,
    filterCopy = filter,
    region = region,
    regionCopy = region,
    timestamp = timestamp
  ), safe = safe, refresh = refresh)
  bunddev_tidy_smard(response, operation_id = "table")
}

bunddev_tidy_smard <- function(response, operation_id = NULL) {
  if (operation_id == "indices") {
    if (is.null(response$timestamps)) {
      return(tibble::tibble())
    }
    return(tibble::tibble(timestamp = purrr::map_dbl(response$timestamps, as.numeric)))
  }

  if (operation_id == "timeseries") {
    series <- response$series
    if (is.null(series) || length(series) == 0) {
      return(tibble::tibble())
    }
    pull_value <- function(x, idx) {
      if (length(x) < idx || is.null(x[[idx]])) {
        return(NA_real_)
      }
      as.numeric(x[[idx]])
    }
    return(tibble::tibble(
      timestamp = purrr::map_dbl(series, ~ pull_value(.x, 1)),
      value = purrr::map_dbl(series, ~ pull_value(.x, 2))
    ))
  }

  if (operation_id == "table") {
    series <- response$series
    if (is.null(series) || length(series) == 0) {
      return(tibble::tibble())
    }
    values <- purrr::map_dfr(series, function(item) {
      if (is.null(item$values) || length(item$values) == 0) {
        return(tibble::tibble())
      }
      purrr::map_dfr(item$values, function(value) {
        tibble::tibble(
          timestamp = as.numeric(value$timestamp),
          value = purrr::map_dbl(value$versions, ~ as.numeric(.x$value)),
          name = purrr::map_chr(value$versions, ~ if (is.null(.x$name)) NA_character_ else .x$name)
        )
      })
    })
    return(values)
  }

  tibble::tibble()
}

bunddev_smard_indices <- function(filter, region = "DE", resolution = "hour") {
  smard_indices(filter = filter, region = region, resolution = resolution)
}

bunddev_smard_timeseries <- function(filter, region = "DE", resolution = "hour", timestamp) {
  smard_timeseries(filter = filter, region = region, resolution = resolution, timestamp = timestamp)
}

bunddev_smard_table <- function(filter, region = "DE", timestamp) {
  smard_table(filter = filter, region = region, timestamp = timestamp)
}

smard_request <- function(operation_id, path, params, safe = TRUE, refresh = FALSE) {
  base_url <- "https://www.smard.de/app"
  url <- paste0(base_url, path)

  if (isTRUE(safe)) {
    bunddev_rate_limit_wait("smard")
  }

  cache_path <- NULL
  if (isTRUE(safe)) {
    cache_path <- bunddev_response_cache_path("smard", operation_id, params)
    if (!isTRUE(refresh) && file.exists(cache_path)) {
      raw_body <- readBin(cache_path, "raw", n = file.info(cache_path)$size)
      return(bunddev_parse_response(raw_body, "json"))
    }
  }

  req <- httr2::request(url)
  resp <- httr2::req_perform(req)
  raw_body <- httr2::resp_body_raw(resp)

  if (!is.null(cache_path)) {
    writeBin(raw_body, cache_path)
  }

  bunddev_parse_response(raw_body, "json")
}
