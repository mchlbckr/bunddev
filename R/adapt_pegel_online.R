#' List Pegel-Online stations
#'
#' @param params Named list of query parameters:
#'   \describe{
#'     \item{includeTimeseries}{Include timeseries metadata (`TRUE`/`FALSE`).}
#'     \item{includeCurrentMeasurement}{Include current measurement metadata (`TRUE`/`FALSE`).}
#'     \item{includeCharacteristicValues}{Include characteristic values (`TRUE`/`FALSE`).}
#'     \item{waters}{Filter by water shortnames (character vector).}
#'     \item{ids}{Filter by station ids (character vector).}
#'     \item{timeseries}{Timeseries shortname filter (character).}
#'     \item{fuzzyId}{Fuzzy station id/name search (character).}
#'     \item{latitude}{Latitude center for geo search (numeric).}
#'     \item{longitude}{Longitude center for geo search (numeric).}
#'     \item{radius}{Radius for geo search (numeric).}
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
#' The Pegel-Online API provides water level station metadata. Use query
#' parameters to filter stations by water, ids, or location. API documentation: \url{https://pegel-online.api.bund.dev}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' [pegel_online_station()] for a single station and
#' [pegel_online_measurements()] for time series values.
#'
#' @examples
#' \dontrun{
#' pegel_online_stations(params = list(limit = 5))
#' }
#'
#' @return A tibble with one row per station:
#' \describe{
#'   \item{uuid}{Station UUID (character).}
#'   \item{number}{Station number/code (character).}
#'   \item{shortname}{Short station name (character).}
#'   \item{longname}{Long station name (character).}
#'   \item{km}{River kilometer (numeric).}
#'   \item{agency}{Responsible agency (character).}
#'   \item{longitude}{Longitude (numeric).}
#'   \item{latitude}{Latitude (numeric).}
#'   \item{water}{Water metadata (list-column).}
#'   \item{timeseries}{Timeseries metadata (list-column).}
#' }
#' @family Pegel Online
#' @export
pegel_online_stations <- function(params = list(),
                                  safe = TRUE,
                                  refresh = FALSE,
                                  flatten = FALSE,
                                  flatten_mode = "json") {
  response <- bunddev_call(
    "pegel_online",
    "getStations",
    params = params,
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  data <- pegel_online_tidy_stations(response)
  if (flatten) {
    return(bunddev_flatten_list_cols(data, cols = c("water", "timeseries"), mode = flatten_mode))
  }

  data
}

#' Get a Pegel-Online station
#'
#' @param station Station UUID, name, or number.
#' @inheritParams pegel_online_stations
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
#' Fetches a single station record. API documentation: \url{https://pegel-online.api.bund.dev}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' [pegel_online_stations()] and [pegel_online_timeseries()].
#'
#' @examples
#' \dontrun{
#' stations <- pegel_online_stations(params = list(limit = 1))
#' pegel_online_station(stations$uuid[[1]])
#' }
#'
#' @return A one-row tibble with the same columns as [pegel_online_stations()].
#' @family Pegel Online
#' @export
pegel_online_station <- function(station,
                                 params = list(),
                                 safe = TRUE,
                                 refresh = FALSE,
                                 flatten = FALSE,
                                 flatten_mode = "json") {
  params$station <- station
  response <- bunddev_call(
    "pegel_online",
    "getStationsById",
    params = params,
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  data <- pegel_online_tidy_station(response)
  if (flatten) {
    return(bunddev_flatten_list_cols(data, cols = c("water", "timeseries"), mode = flatten_mode))
  }

  data
}

#' List Pegel-Online waters
#'
#' @inheritParams pegel_online_stations
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
#' Lists waters available in Pegel-Online. API documentation: \url{https://pegel-online.api.bund.dev}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' [pegel_online_stations()] for station metadata.
#'
#' @examples
#' \dontrun{
#' pegel_online_waters(params = list(limit = 5))
#' }
#'
#' @return A tibble with one row per water:
#' \describe{
#'   \item{shortname}{Water shortname (character).}
#'   \item{longname}{Water long name (character).}
#'   \item{stations}{Associated stations (list-column).}
#'   \item{timeseries}{Associated timeseries metadata (list-column).}
#' }
#' @family Pegel Online
#' @export
pegel_online_waters <- function(params = list(),
                                safe = TRUE,
                                refresh = FALSE,
                                flatten = FALSE,
                                flatten_mode = "json") {
  response <- bunddev_call(
    "pegel_online",
    "getWaters",
    params = params,
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  data <- pegel_online_tidy_waters(response)
  if (flatten) {
    return(bunddev_flatten_list_cols(data, cols = c("stations", "timeseries"), mode = flatten_mode))
  }

  data
}

#' Get Pegel-Online timeseries metadata
#'
#' @param station Station UUID, name, or number.
#' @param timeseries Timeseries shortname.
#' @inheritParams pegel_online_stations
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns metadata for a timeseries, including unit and gauge zero. Official
#' docs: https://pegel-online.api.bund.dev.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' [pegel_online_measurements()] for measurement values.
#'
#' @examples
#' \dontrun{
#' stations <- pegel_online_stations(params = list(limit = 1))
#' pegel_online_timeseries(stations$uuid[[1]], "W")
#' }
#'
#' @return A one-row tibble with timeseries metadata:
#' \describe{
#'   \item{shortname}{Timeseries shortname (character).}
#'   \item{longname}{Timeseries long name (character).}
#'   \item{unit}{Measurement unit (character).}
#'   \item{equidistance}{Sampling interval/equidistance (numeric).}
#'   \item{gauge_zero}{Gauge zero metadata (list-column).}
#'   \item{characteristic_values}{Characteristic values (list-column).}
#'   \item{current_value}{Current measured value (numeric).}
#'   \item{current_timestamp}{Current timestamp as string (character).}
#'   \item{current_timestamp_time}{Current timestamp as `POSIXct` in Europe/Berlin.}
#' }
#' @family Pegel Online
#' @export
pegel_online_timeseries <- function(station,
                                    timeseries,
                                    params = list(),
                                    safe = TRUE,
                                    refresh = FALSE) {
  params$station <- station
  params$timeseries <- timeseries
  response <- bunddev_call(
    "pegel_online",
    "getCurrentMeasurmentByStation",
    params = params,
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  pegel_online_tidy_timeseries(response)
}

#' Get Pegel-Online measurements
#'
#' @param station Station UUID, name, or number.
#' @param timeseries Timeseries shortname.
#' @param start Start timestamp in ISO 8601.
#' @param end End timestamp in ISO 8601.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns measurement values for a station timeseries. Timestamps must be
#' ISO 8601 strings. API documentation: \url{https://pegel-online.api.bund.dev}.
#'
#' @seealso
#' [pegel_online_timeseries()] for metadata and
#' [pegel_online_measurements_plot()] for PNG plots.
#'
#' @examples
#' \dontrun{
#' stations <- pegel_online_stations(params = list(limit = 1))
#' pegel_online_measurements(stations$uuid[[1]], "W",
#'   start = "2024-01-01T00:00:00Z",
#'   end = "2024-01-02T00:00:00Z"
#' )
#' }
#'
#' @return A tibble with one row per measurement:
#' \describe{
#'   \item{timestamp}{Measurement timestamp string (character).}
#'   \item{value}{Measured value (numeric).}
#'   \item{timestamp_time}{Measurement timestamp as `POSIXct` in Europe/Berlin.}
#' }
#' @family Pegel Online
#' @export
pegel_online_measurements <- function(station,
                                      timeseries,
                                      start = NULL,
                                      end = NULL,
                                      safe = TRUE,
                                      refresh = FALSE) {
  params <- list(station = station, timeseries = timeseries)
  if (!is.null(start)) {
    params$start <- start
  }
  if (!is.null(end)) {
    params$end <- end
  }

  response <- bunddev_call(
    "pegel_online",
    "getMeasurementByStation",
    params = params,
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  pegel_online_tidy_measurements(response)
}

#' Get Pegel-Online measurements plot
#'
#' @param station Station UUID, name, or number.
#' @param timeseries Timeseries shortname.
#' @param start Start timestamp in ISO 8601.
#' @param end End timestamp in ISO 8601.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns a PNG plot for the measurements endpoint. API documentation: \url{https://pegel-online.api.bund.dev}.
#'
#' @seealso
#' [pegel_online_measurements()] for numeric values.
#'
#' @examples
#' \dontrun{
#' stations <- pegel_online_stations(params = list(limit = 1))
#' pegel_online_measurements_plot(stations$uuid[[1]], "W",
#'   start = "2024-01-01T00:00:00Z",
#'   end = "2024-01-02T00:00:00Z"
#' )
#' }
#'
#' @return A one-row tibble with:
#' \describe{
#'   \item{station}{Requested station id (character).}
#'   \item{timeseries}{Requested timeseries shortname (character).}
#'   \item{png}{Raw PNG bytes (list-column with raw vector).}
#' }
#' @family Pegel Online
#' @export
pegel_online_measurements_plot <- function(station,
                                           timeseries,
                                           start = NULL,
                                           end = NULL,
                                           safe = TRUE,
                                           refresh = FALSE) {
  params <- list(station = station, timeseries = timeseries)
  if (!is.null(start)) {
    params$start <- start
  }
  if (!is.null(end)) {
    params$end <- end
  }

  response <- bunddev_call(
    "pegel_online",
    "getMeasurementDiagramByStation",
    params = params,
    parse = "raw",
    safe = safe,
    refresh = refresh
  )

  tibble::tibble(station = station, timeseries = timeseries, png = list(response))
}

pegel_online_tidy_stations <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  chr_or_na <- function(value) {
    if (is.null(value)) NA_character_ else as.character(value)
  }
  num_or_na <- function(value) {
    if (is.null(value)) NA_real_ else as.numeric(value)
  }

  tibble::tibble(
    uuid = purrr::map_chr(response, ~ chr_or_na(.x$uuid)),
    number = purrr::map_chr(response, ~ chr_or_na(.x$number)),
    shortname = purrr::map_chr(response, ~ chr_or_na(.x$shortname)),
    longname = purrr::map_chr(response, ~ chr_or_na(.x$longname)),
    km = purrr::map_dbl(response, ~ num_or_na(.x$km)),
    agency = purrr::map_chr(response, ~ chr_or_na(.x$agency)),
    longitude = purrr::map_dbl(response, ~ num_or_na(.x$longitude)),
    latitude = purrr::map_dbl(response, ~ num_or_na(.x$latitude)),
    water = purrr::map(response, ~ .x$water %||% list()),
    timeseries = purrr::map(response, ~ .x$timeseries %||% list())
  )
}

pegel_online_tidy_station <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }
  pegel_online_tidy_stations(list(response))
}

pegel_online_tidy_waters <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }
  chr_or_na <- function(value) {
    if (is.null(value)) NA_character_ else as.character(value)
  }
  tibble::tibble(
    shortname = purrr::map_chr(response, ~ chr_or_na(.x$shortname)),
    longname = purrr::map_chr(response, ~ chr_or_na(.x$longname)),
    stations = purrr::map(response, ~ .x$stations %||% list()),
    timeseries = purrr::map(response, ~ .x$timeseries %||% list())
  )
}

pegel_online_tidy_timeseries <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }
  chr_or_na <- function(value) {
    if (is.null(value)) NA_character_ else as.character(value)
  }
  num_or_na <- function(value) {
    if (is.null(value)) NA_real_ else as.numeric(value)
  }

  current <- response$currentMeasurement %||% list()
  current_value <- num_or_na(current$value)
  current_time <- current$timestamp %||% NA_character_

  tibble::tibble(
    shortname = chr_or_na(response$shortname),
    longname = chr_or_na(response$longname),
    unit = chr_or_na(response$unit),
    equidistance = num_or_na(response$equidistance),
    gauge_zero = list(response$gaugeZero %||% list()),
    characteristic_values = list(response$characteristicValues %||% list()),
    current_value = current_value,
    current_timestamp = chr_or_na(current_time),
    current_timestamp_time = as.POSIXct(current_time, tz = "Europe/Berlin")
  )
}

pegel_online_tidy_measurements <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  timestamps <- purrr::map_chr(response, ~ as.character(.x$timestamp %||% NA_character_))
  values <- purrr::map_dbl(response, ~ as.numeric(.x$value %||% NA_real_))

  tibble::tibble(
    timestamp = timestamps,
    value = values,
    timestamp_time = as.POSIXct(timestamps, tz = "Europe/Berlin")
  )
}

bunddev_pegel_online_stations <- function(params = list(),
                                          safe = TRUE,
                                          refresh = FALSE,
                                          flatten = FALSE,
                                          flatten_mode = "json") {
  pegel_online_stations(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_pegel_online_station <- function(station,
                                         params = list(),
                                         safe = TRUE,
                                         refresh = FALSE,
                                         flatten = FALSE,
                                         flatten_mode = "json") {
  pegel_online_station(
    station = station,
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_pegel_online_waters <- function(params = list(),
                                        safe = TRUE,
                                        refresh = FALSE,
                                        flatten = FALSE,
                                        flatten_mode = "json") {
  pegel_online_waters(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_pegel_online_timeseries <- function(station,
                                            timeseries,
                                            params = list(),
                                            safe = TRUE,
                                            refresh = FALSE) {
  pegel_online_timeseries(
    station = station,
    timeseries = timeseries,
    params = params,
    safe = safe,
    refresh = refresh
  )
}

bunddev_pegel_online_measurements <- function(station,
                                              timeseries,
                                              start = NULL,
                                              end = NULL,
                                              safe = TRUE,
                                              refresh = FALSE) {
  pegel_online_measurements(
    station = station,
    timeseries = timeseries,
    start = start,
    end = end,
    safe = safe,
    refresh = refresh
  )
}

bunddev_pegel_online_measurements_plot <- function(station,
                                                   timeseries,
                                                   start = NULL,
                                                   end = NULL,
                                                   safe = TRUE,
                                                   refresh = FALSE) {
  pegel_online_measurements_plot(
    station = station,
    timeseries = timeseries,
    start = start,
    end = end,
    safe = safe,
    refresh = refresh
  )
}
