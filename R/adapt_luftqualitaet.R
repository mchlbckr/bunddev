#' List air quality measurements
#'
#' @param params Named list of query parameters. Common keys:
#'   \describe{
#'     \item{date_from}{Start date/time filter (character, ISO-8601/date).}
#'     \item{date_to}{End date/time filter (character, ISO-8601/date).}
#'     \item{component}{Pollutant component id/code (character).}
#'     \item{scope}{Scope id/code (character).}
#'     \item{station}{Station id/code (character).}
#'     \item{network}{Network id/code (character).}
#'     \item{lang}{Language code for labels/descriptions (character).}
#'   }
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' The Luftqualitaet API provides air quality data and metadata from the
#' Umweltbundesamt. Use query parameters to filter by date/time and station.
#' API documentation: \url{https://luftqualitaet.api.bund.dev}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' [luftqualitaet_measures()] for measurement metadata and
#' [luftqualitaet_components()] for pollutant components.
#'
#' @examples
#' \dontrun{
#' luftqualitaet_airquality(params = list(
#'   date_from = "2024-01-01",
#'   date_to = "2024-01-02"
#' ))
#' }
#'
#' @return A tibble with one row per air-quality measurement record.
#' \describe{
#'   \item{Indexed value columns}{Columns are derived from API `indices` metadata and represent scalar values for each returned record.}
#'   \item{Index key column}{Included when the API provides a named index key (for example station id/date key).}
#' }
#' @family Luftqualitaet
#' @export
luftqualitaet_airquality <- function(params = list(), safe = TRUE, refresh = FALSE) {
  response <- luftqualitaet_request("/airquality/json", params, safe, refresh)
  luftqualitaet_tidy_table(response)
}

#' Get air quality date limits
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns date limits for air quality measurements. API documentation: \url{https://luftqualitaet.api.bund.dev}.
#'
#' @return A one-row tibble with available date limits for the endpoint.
#'
#' \describe{
#'   \item{Indexed value columns}{Columns are derived from API `indices` metadata and represent scalar values for each returned record.}
#'   \item{Index key column}{Included when the API provides a named index key (for example station id/date key).}
#' }
#' @family Luftqualitaet
#' @export
luftqualitaet_airquality_limits <- function(safe = TRUE, refresh = FALSE) {
  response <- luftqualitaet_request("/airquality/limits", list(), safe, refresh)
  luftqualitaet_tidy_table(response)
}

#' List annual balances
#'
#' @inheritParams luftqualitaet_airquality
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns annual balance data for a component and year. API documentation: \url{https://luftqualitaet.api.bund.dev}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @return A tibble with one row per annual-balance record.
#' \describe{
#'   \item{Indexed value columns}{Columns are derived from API `indices` metadata and represent scalar values for each returned record.}
#'   \item{Index key column}{Included when the API provides a named index key (for example station id/date key).}
#' }
#' @family Luftqualitaet
#' @export
luftqualitaet_annualbalances <- function(params = list(), safe = TRUE, refresh = FALSE) {
  response <- luftqualitaet_request("/annualbalances/json", params, safe, refresh)
  luftqualitaet_tidy_table(response)
}

#' List components
#'
#' @inheritParams luftqualitaet_airquality
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns available pollutant components. API documentation: \url{https://luftqualitaet.api.bund.dev}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @return A tibble with one row per component metadata entry.
#' \describe{
#'   \item{Indexed value columns}{Columns are derived from API `indices` metadata and represent scalar values for each returned record.}
#'   \item{Index key column}{Included when the API provides a named index key (for example station id/date key).}
#' }
#' @family Luftqualitaet
#' @export
luftqualitaet_components <- function(params = list(), safe = TRUE, refresh = FALSE) {
  response <- luftqualitaet_request("/components/json", params, safe, refresh)
  luftqualitaet_tidy_table(response)
}

#' List measurements metadata
#'
#' @inheritParams luftqualitaet_airquality
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns measurement metadata for stations, components, and scopes. Official
#' docs: https://luftqualitaet.api.bund.dev.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @return A tibble with one row per measurement metadata entry.
#' \describe{
#'   \item{Indexed value columns}{Columns are derived from API `indices` metadata and represent scalar values for each returned record.}
#'   \item{Index key column}{Included when the API provides a named index key (for example station id/date key).}
#' }
#' @family Luftqualitaet
#' @export
luftqualitaet_measures <- function(params = list(), safe = TRUE, refresh = FALSE) {
  response <- luftqualitaet_request("/measures/json", params, safe, refresh)
  luftqualitaet_tidy_table(response)
}

#' Get measurement date limits
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns date limits for measurement metadata. API documentation: \url{https://luftqualitaet.api.bund.dev}.
#'
#' @return A one-row tibble with available date limits for the endpoint.
#'
#' \describe{
#'   \item{Indexed value columns}{Columns are derived from API `indices` metadata and represent scalar values for each returned record.}
#'   \item{Index key column}{Included when the API provides a named index key (for example station id/date key).}
#' }
#' @family Luftqualitaet
#' @export
luftqualitaet_measures_limits <- function(safe = TRUE, refresh = FALSE) {
  response <- luftqualitaet_request("/measures/limits", list(), safe, refresh)
  luftqualitaet_tidy_table(response)
}

#' List networks
#'
#' @inheritParams luftqualitaet_airquality
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns networks used by the Luftqualitaet API. API documentation: \url{https://luftqualitaet.api.bund.dev}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @return A tibble with one row per network metadata entry.
#' \describe{
#'   \item{Indexed value columns}{Columns are derived from API `indices` metadata and represent scalar values for each returned record.}
#'   \item{Index key column}{Included when the API provides a named index key (for example station id/date key).}
#' }
#' @family Luftqualitaet
#' @export
luftqualitaet_networks <- function(params = list(), safe = TRUE, refresh = FALSE) {
  response <- luftqualitaet_request("/networks/json", params, safe, refresh)
  luftqualitaet_tidy_table(response)
}

#' List scopes
#'
#' @inheritParams luftqualitaet_airquality
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns scopes used by the Luftqualitaet API. API documentation: \url{https://luftqualitaet.api.bund.dev}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @return A tibble with one row per scope metadata entry.
#' \describe{
#'   \item{Indexed value columns}{Columns are derived from API `indices` metadata and represent scalar values for each returned record.}
#'   \item{Index key column}{Included when the API provides a named index key (for example station id/date key).}
#' }
#' @family Luftqualitaet
#' @export
luftqualitaet_scopes <- function(params = list(), safe = TRUE, refresh = FALSE) {
  response <- luftqualitaet_request("/scopes/json", params, safe, refresh)
  luftqualitaet_tidy_table(response)
}

#' List station settings
#'
#' @inheritParams luftqualitaet_airquality
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns station settings metadata. API documentation: \url{https://luftqualitaet.api.bund.dev}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @return A tibble with one row per station-settings metadata entry.
#' \describe{
#'   \item{Indexed value columns}{Columns are derived from API `indices` metadata and represent scalar values for each returned record.}
#'   \item{Index key column}{Included when the API provides a named index key (for example station id/date key).}
#' }
#' @family Luftqualitaet
#' @export
luftqualitaet_stationsettings <- function(params = list(), safe = TRUE, refresh = FALSE) {
  response <- luftqualitaet_request("/stationsettings/json", params, safe, refresh)
  luftqualitaet_tidy_table(response)
}

#' List station types
#'
#' @inheritParams luftqualitaet_airquality
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns station types metadata. API documentation: \url{https://luftqualitaet.api.bund.dev}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @return A tibble with one row per station-type metadata entry.
#' \describe{
#'   \item{Indexed value columns}{Columns are derived from API `indices` metadata and represent scalar values for each returned record.}
#'   \item{Index key column}{Included when the API provides a named index key (for example station id/date key).}
#' }
#' @family Luftqualitaet
#' @export
luftqualitaet_stationtypes <- function(params = list(), safe = TRUE, refresh = FALSE) {
  response <- luftqualitaet_request("/stationtypes/json", params, safe, refresh)
  luftqualitaet_tidy_table(response)
}

#' List thresholds
#'
#' @inheritParams luftqualitaet_airquality
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns threshold metadata for components and scopes. API documentation: \url{https://luftqualitaet.api.bund.dev}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @return A tibble with one row per threshold metadata entry.
#' \describe{
#'   \item{Indexed value columns}{Columns are derived from API `indices` metadata and represent scalar values for each returned record.}
#'   \item{Index key column}{Included when the API provides a named index key (for example station id/date key).}
#' }
#' @family Luftqualitaet
#' @export
luftqualitaet_thresholds <- function(params = list(), safe = TRUE, refresh = FALSE) {
  response <- luftqualitaet_request("/thresholds/json", params, safe, refresh)
  luftqualitaet_tidy_table(response)
}

#' List transgressions
#'
#' @inheritParams luftqualitaet_airquality
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns exceedances (transgressions) data. API documentation: \url{https://luftqualitaet.api.bund.dev}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @return A tibble with one row per transgression record.
#' \describe{
#'   \item{Indexed value columns}{Columns are derived from API `indices` metadata and represent scalar values for each returned record.}
#'   \item{Index key column}{Included when the API provides a named index key (for example station id/date key).}
#' }
#' @family Luftqualitaet
#' @export
luftqualitaet_transgressions <- function(params = list(), safe = TRUE, refresh = FALSE) {
  response <- luftqualitaet_request("/transgressions/json", params, safe, refresh)
  luftqualitaet_tidy_table(response)
}

#' List transgression types
#'
#' @inheritParams luftqualitaet_airquality
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns available transgression types. API documentation: \url{https://luftqualitaet.api.bund.dev}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @return A tibble with one row per transgression-type metadata entry.
#' \describe{
#'   \item{Indexed value columns}{Columns are derived from API `indices` metadata and represent scalar values for each returned record.}
#'   \item{Index key column}{Included when the API provides a named index key (for example station id/date key).}
#' }
#' @family Luftqualitaet
#' @export
luftqualitaet_transgressiontypes <- function(params = list(), safe = TRUE, refresh = FALSE) {
  response <- luftqualitaet_request("/transgressiontypes/json", params, safe, refresh)
  luftqualitaet_tidy_table(response)
}

#' List combined metadata
#'
#' @inheritParams luftqualitaet_airquality
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns combined metadata for a given use case. API documentation: \url{https://luftqualitaet.api.bund.dev}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @return A tibble with one row per combined metadata record.
#' \describe{
#'   \item{Indexed value columns}{Columns are derived from API `indices` metadata and represent scalar values for each returned record.}
#'   \item{Index key column}{Included when the API provides a named index key (for example station id/date key).}
#' }
#' @family Luftqualitaet
#' @export
luftqualitaet_meta <- function(params = list(), safe = TRUE, refresh = FALSE) {
  response <- luftqualitaet_request("/meta/json", params, safe, refresh)
  luftqualitaet_tidy_table(response)
}

luftqualitaet_request <- function(path, query, safe = TRUE, refresh = FALSE) {
  bunddev_call(
    "luftqualitaet",
    path = path,
    method = "GET",
    params = query %||% list(),
    parse = "json",
    safe = safe,
    refresh = refresh
  )
}

luftqualitaet_tidy_table <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  indices <- response$indices %||% list()
  data <- response$data
  if (is.null(data)) {
    data <- response[setdiff(names(response), c("count", "indices", "request"))]
  }

  if (is.null(data) || length(data) == 0) {
    return(tibble::tibble())
  }

  key_name <- NULL
  col_names <- NULL
  if (length(indices) > 0) {
    if (length(indices) == 1 && is.list(indices[[1]]) && all(purrr::map_lgl(indices[[1]], is.character))) {
      key_name <- names(indices)[[1]]
      col_names <- c(key_name, unname(unlist(indices[[1]])))
    } else {
      col_names <- unname(unlist(indices))
    }
  }

  rows <- data
  keys <- names(rows)

  row_list <- purrr::map(rows, function(values) {
    if (is.null(values)) {
      values <- list()
    }
    as.list(values)
  })

  if (!is.null(key_name) && !is.null(keys)) {
    row_list <- purrr::map2(row_list, keys, function(values, key) {
      c(setNames(list(key), key_name), values)
    })
  }

  if (!is.null(col_names)) {
    row_list <- purrr::map(row_list, function(values) {
      length(values) <- length(col_names)
      names(values) <- col_names
      values
    })
  }

  dplyr::bind_rows(row_list)
}

bunddev_luftqualitaet_airquality <- function(params = list(), safe = TRUE, refresh = FALSE) {
  luftqualitaet_airquality(params = params, safe = safe, refresh = refresh)
}

bunddev_luftqualitaet_airquality_limits <- function(safe = TRUE, refresh = FALSE) {
  luftqualitaet_airquality_limits(safe = safe, refresh = refresh)
}

bunddev_luftqualitaet_annualbalances <- function(params = list(), safe = TRUE, refresh = FALSE) {
  luftqualitaet_annualbalances(params = params, safe = safe, refresh = refresh)
}

bunddev_luftqualitaet_components <- function(params = list(), safe = TRUE, refresh = FALSE) {
  luftqualitaet_components(params = params, safe = safe, refresh = refresh)
}

bunddev_luftqualitaet_measures <- function(params = list(), safe = TRUE, refresh = FALSE) {
  luftqualitaet_measures(params = params, safe = safe, refresh = refresh)
}

bunddev_luftqualitaet_measures_limits <- function(safe = TRUE, refresh = FALSE) {
  luftqualitaet_measures_limits(safe = safe, refresh = refresh)
}

bunddev_luftqualitaet_networks <- function(params = list(), safe = TRUE, refresh = FALSE) {
  luftqualitaet_networks(params = params, safe = safe, refresh = refresh)
}

bunddev_luftqualitaet_scopes <- function(params = list(), safe = TRUE, refresh = FALSE) {
  luftqualitaet_scopes(params = params, safe = safe, refresh = refresh)
}

bunddev_luftqualitaet_stationsettings <- function(params = list(), safe = TRUE, refresh = FALSE) {
  luftqualitaet_stationsettings(params = params, safe = safe, refresh = refresh)
}

bunddev_luftqualitaet_stationtypes <- function(params = list(), safe = TRUE, refresh = FALSE) {
  luftqualitaet_stationtypes(params = params, safe = safe, refresh = refresh)
}

bunddev_luftqualitaet_thresholds <- function(params = list(), safe = TRUE, refresh = FALSE) {
  luftqualitaet_thresholds(params = params, safe = safe, refresh = refresh)
}

bunddev_luftqualitaet_transgressions <- function(params = list(), safe = TRUE, refresh = FALSE) {
  luftqualitaet_transgressions(params = params, safe = safe, refresh = refresh)
}

bunddev_luftqualitaet_transgressiontypes <- function(params = list(), safe = TRUE, refresh = FALSE) {
  luftqualitaet_transgressiontypes(params = params, safe = safe, refresh = refresh)
}

bunddev_luftqualitaet_meta <- function(params = list(), safe = TRUE, refresh = FALSE) {
  luftqualitaet_meta(params = params, safe = safe, refresh = refresh)
}
