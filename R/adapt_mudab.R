#' List MUDAB project stations
#'
#' @param filter Optional filter definition.
#' @param range Optional range specification.
#' @param orderby Optional ordering specification.
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
#' Returns project stations from the MUDAB database.
#' API documentation: \url{https://mudab.api.bund.dev}.
#'
#' @examples
#' \dontrun{
#' mudab_project_stations(range = list(from = 0, count = 5))
#' }
#'
#' @return A tibble with one row per returned `V_MUDAB_PROJECTSTATION` record.
#' Top-level scalar API fields are returned as tibble columns; nested
#' objects or arrays are kept in list-columns unless the function provides
#' `flatten` / `flatten_mode` controls.
#' @family MUDAB
#' @export
mudab_project_stations <- function(filter = NULL,
                                   range = NULL,
                                   orderby = NULL,
                                   safe = TRUE,
                                   refresh = FALSE,
                                   flatten = FALSE,
                                   flatten_mode = "json") {
  response <- mudab_request(
    "/PROJECTSTATION_SMALL",
    body = mudab_build_body(filter, range, orderby),
    safe = safe,
    refresh = refresh
  )

  mudab_maybe_flatten(mudab_tidy_key(response, "V_MUDAB_PROJECTSTATION"), flatten, flatten_mode)
}

#' List MUDAB stations
#'
#' @param filter Optional filter definition.
#' @param range Optional range specification.
#' @param orderby Optional ordering specification.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns measurement stations from the MUDAB database.
#' API documentation: \url{https://mudab.api.bund.dev}.
#'
#' @examples
#' \dontrun{
#' mudab_stations(range = list(from = 0, count = 5))
#' }
#'
#' @return A tibble with one row per returned `STATION_SMALL` record.
#' Top-level scalar API fields are returned as tibble columns; nested
#' objects or arrays are kept in list-columns unless the function provides
#' `flatten` / `flatten_mode` controls.
#' @family MUDAB
#' @export
mudab_stations <- function(filter = NULL,
                           range = NULL,
                           orderby = NULL,
                           safe = TRUE,
                           refresh = FALSE) {
  response <- mudab_request(
    "/STATION_SMALL",
    body = mudab_build_body(filter, range, orderby),
    safe = safe,
    refresh = refresh
  )

  mudab_tidy_key(response, "STATION_SMALL")
}

#' List MUDAB parameters
#'
#' @param filter Optional filter definition.
#' @param range Optional range specification.
#' @param orderby Optional ordering specification.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns measurement parameters from the MUDAB database.
#' API documentation: \url{https://mudab.api.bund.dev}.
#'
#' @examples
#' \dontrun{
#' mudab_parameters(range = list(from = 0, count = 5))
#' }
#'
#' @return A tibble with one row per returned `MV_PARAMETER` record.
#' Top-level scalar API fields are returned as tibble columns; nested
#' objects or arrays are kept in list-columns unless the function provides
#' `flatten` / `flatten_mode` controls.
#' @family MUDAB
#' @export
mudab_parameters <- function(filter = NULL,
                             range = NULL,
                             orderby = NULL,
                             safe = TRUE,
                             refresh = FALSE) {
  response <- mudab_request(
    "/MV_PARAMETER",
    body = mudab_build_body(filter, range, orderby),
    safe = safe,
    refresh = refresh
  )

  mudab_tidy_key(response, "MV_PARAMETER")
}

#' List MUDAB parameter values
#'
#' @param filter Optional filter definition.
#' @param range Optional range specification.
#' @param orderby Optional ordering specification.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns measurement values for parameters from the MUDAB database.
#' API documentation: \url{https://mudab.api.bund.dev}.
#'
#' @examples
#' \dontrun{
#' mudab_parameter_values(range = list(from = 0, count = 5))
#' }
#'
#' @return A tibble with one row per returned `MV_STATION_MSMNT` record.
#' Includes parsed `*_time` columns (`POSIXct`, Europe/Berlin) when matching
#' date/time fields are present.
#' @family MUDAB
#' @export
mudab_parameter_values <- function(filter = NULL,
                                   range = NULL,
                                   orderby = NULL,
                                   safe = TRUE,
                                   refresh = FALSE) {
  response <- mudab_request(
    "/MV_STATION_MSMNT",
    body = mudab_build_body(filter, range, orderby),
    safe = safe,
    refresh = refresh
  )

  mudab_tidy_key(response, "MV_STATION_MSMNT")
}

#' List MUDAB parameters (Biologie)
#'
#' @param filter Optional filter definition.
#' @param range Optional range specification.
#' @param orderby Optional ordering specification.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns parameter entries for the Biologie compartment.
#' API documentation: \url{https://mudab.api.bund.dev}.
#'
#' @examples
#' \dontrun{
#' mudab_parameters_biologie(range = list(from = 0, count = 5))
#' }
#'
#' @return A tibble with one row per returned `MV_PARAMETER_BIOLOGIE` record.
#' Top-level scalar API fields are returned as tibble columns; nested
#' objects or arrays are kept in list-columns unless the function provides
#' `flatten` / `flatten_mode` controls.
#' @family MUDAB
#' @export
mudab_parameters_biologie <- function(filter = NULL,
                                      range = NULL,
                                      orderby = NULL,
                                      safe = TRUE,
                                      refresh = FALSE) {
  response <- mudab_request(
    "/MV_PARAMETER_BIOLOGIE",
    body = mudab_build_body(filter, range, orderby),
    safe = safe,
    refresh = refresh
  )

  mudab_tidy_key(response, "MV_PARAMETER_BIOLOGIE")
}

#' List MUDAB parameters (Biota)
#'
#' @param filter Optional filter definition.
#' @param range Optional range specification.
#' @param orderby Optional ordering specification.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns parameter entries for the Biota compartment.
#' API documentation: \url{https://mudab.api.bund.dev}.
#'
#' @examples
#' \dontrun{
#' mudab_parameters_biota(range = list(from = 0, count = 5))
#' }
#'
#' @return A tibble with one row per returned `MV_PARAMETER_BIOTA` record.
#' Top-level scalar API fields are returned as tibble columns; nested
#' objects or arrays are kept in list-columns unless the function provides
#' `flatten` / `flatten_mode` controls.
#' @family MUDAB
#' @export
mudab_parameters_biota <- function(filter = NULL,
                                   range = NULL,
                                   orderby = NULL,
                                   safe = TRUE,
                                   refresh = FALSE) {
  response <- mudab_request(
    "/MV_PARAMETER_BIOTA",
    body = mudab_build_body(filter, range, orderby),
    safe = safe,
    refresh = refresh
  )

  mudab_tidy_key(response, "MV_PARAMETER_BIOTA")
}

#' List MUDAB parameters (Wasser)
#'
#' @param filter Optional filter definition.
#' @param range Optional range specification.
#' @param orderby Optional ordering specification.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns parameter entries for the Wasser compartment.
#' API documentation: \url{https://mudab.api.bund.dev}.
#'
#' @examples
#' \dontrun{
#' mudab_parameters_wasser(range = list(from = 0, count = 5))
#' }
#'
#' @return A tibble with one row per returned `MV_PARAMETER_WASSER` record.
#' Top-level scalar API fields are returned as tibble columns; nested
#' objects or arrays are kept in list-columns unless the function provides
#' `flatten` / `flatten_mode` controls.
#' @family MUDAB
#' @export
mudab_parameters_wasser <- function(filter = NULL,
                                    range = NULL,
                                    orderby = NULL,
                                    safe = TRUE,
                                    refresh = FALSE) {
  response <- mudab_request(
    "/MV_PARAMETER_WASSER",
    body = mudab_build_body(filter, range, orderby),
    safe = safe,
    refresh = refresh
  )

  mudab_tidy_key(response, "MV_PARAMETER_WASSER")
}

#' List MUDAB parameters (Sediment)
#'
#' @param filter Optional filter definition.
#' @param range Optional range specification.
#' @param orderby Optional ordering specification.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns parameter entries for the Sediment compartment.
#' API documentation: \url{https://mudab.api.bund.dev}.
#'
#' @examples
#' \dontrun{
#' mudab_parameters_sediment(range = list(from = 0, count = 5))
#' }
#'
#' @return A tibble with one row per returned `MV_PARAMETER_SEDIMENT` record.
#' Top-level scalar API fields are returned as tibble columns; nested
#' objects or arrays are kept in list-columns unless the function provides
#' `flatten` / `flatten_mode` controls.
#' @family MUDAB
#' @export
mudab_parameters_sediment <- function(filter = NULL,
                                      range = NULL,
                                      orderby = NULL,
                                      safe = TRUE,
                                      refresh = FALSE) {
  response <- mudab_request(
    "/MV_PARAMETER_SEDIMENT",
    body = mudab_build_body(filter, range, orderby),
    safe = safe,
    refresh = refresh
  )

  mudab_tidy_key(response, "MV_PARAMETER_SEDIMENT")
}

#' List MUDAB PLC stations
#'
#' @param filter Optional filter definition.
#' @param range Optional range specification.
#' @param orderby Optional ordering specification.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns HELCOM PLC stations.
#' API documentation: \url{https://mudab.api.bund.dev}.
#'
#' @examples
#' \dontrun{
#' mudab_plc_stations(range = list(from = 0, count = 5))
#' }
#'
#' @return A tibble with one row per returned `V_PLC_STATION` record.
#' Top-level scalar API fields are returned as tibble columns; nested
#' objects or arrays are kept in list-columns unless the function provides
#' `flatten` / `flatten_mode` controls.
#' @family MUDAB
#' @export
mudab_plc_stations <- function(filter = NULL,
                               range = NULL,
                               orderby = NULL,
                               safe = TRUE,
                               refresh = FALSE) {
  response <- mudab_request(
    "/V_PLC_STATION",
    body = mudab_build_body(filter, range, orderby),
    safe = safe,
    refresh = refresh
  )

  mudab_tidy_key(response, "V_PLC_STATION")
}

#' List MUDAB PLC parameters
#'
#' @param filter Optional filter definition.
#' @param range Optional range specification.
#' @param orderby Optional ordering specification.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns parameters measured at PLC stations.
#' API documentation: \url{https://mudab.api.bund.dev}.
#'
#' @examples
#' \dontrun{
#' mudab_plc_parameters(range = list(from = 0, count = 5))
#' }
#'
#' @return A tibble with one row per returned `V_GEMESSENE_PARA_PLC` record.
#' Top-level scalar API fields are returned as tibble columns; nested
#' objects or arrays are kept in list-columns unless the function provides
#' `flatten` / `flatten_mode` controls.
#' @family MUDAB
#' @export
mudab_plc_parameters <- function(filter = NULL,
                                 range = NULL,
                                 orderby = NULL,
                                 safe = TRUE,
                                 refresh = FALSE) {
  response <- mudab_request(
    "/V_GEMESSENE_PARA_PLC",
    body = mudab_build_body(filter, range, orderby),
    safe = safe,
    refresh = refresh
  )

  mudab_tidy_key(response, "V_GEMESSENE_PARA_PLC")
}

#' List MUDAB PLC measurement values
#'
#' @param filter Optional filter definition.
#' @param range Optional range specification.
#' @param orderby Optional ordering specification.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns PLC station measurement values.
#' API documentation: \url{https://mudab.api.bund.dev}.
#'
#' @examples
#' \dontrun{
#' mudab_plc_measurements(range = list(from = 0, count = 5))
#' }
#'
#' @return A tibble with one row per returned `V_PLC_STATION_MSMNT` record.
#' Top-level scalar API fields are returned as tibble columns; nested
#' objects or arrays are kept in list-columns unless the function provides
#' `flatten` / `flatten_mode` controls.
#' @family MUDAB
#' @export
mudab_plc_measurements <- function(filter = NULL,
                                   range = NULL,
                                   orderby = NULL,
                                   safe = TRUE,
                                   refresh = FALSE) {
  response <- mudab_request(
    "/V_MESSWERTE_PLC",
    body = mudab_build_body(filter, range, orderby),
    safe = safe,
    refresh = refresh
  )

  mudab_tidy_key(response, "V_MESSWERTE_PLC")
}

mudab_build_body <- function(filter, range, orderby) {
  body <- list()
  if (!is.null(filter)) {
    body$filter <- filter
  }
  if (!is.null(range)) {
    body$range <- range
  }
  if (!is.null(orderby)) {
    body$orderby <- orderby
  }
  body
}

mudab_request <- function(path, body, safe = TRUE, refresh = FALSE, parse = "json") {
  bunddev_call(
    "mudab",
    path = path,
    method = "POST",
    body = body,
    parse = parse,
    safe = safe,
    refresh = refresh
  )
}

mudab_tidy_key <- function(response, key) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  rows <- response[[key]]
  if (is.null(rows) || length(rows) == 0) {
    return(tibble::tibble())
  }

  data <- purrr::map_dfr(rows, function(item) {
    cleaned <- purrr::map(item, ~ if (is.null(.x)) NA else .x)
    tibble::as_tibble(cleaned)
  })

  mudab_add_time_cols(data)
}

mudab_add_time_cols <- function(data) {
  if (!all(c("DATE_STM", "TIME_STM") %in% names(data))) {
    return(data)
  }

  datetime <- paste0(data$DATE_STM, stringr::str_pad(data$TIME_STM, 4, pad = "0"))
  data$datetime_time <- as.POSIXct(datetime, format = "%Y%m%d%H%M", tz = "Europe/Berlin")
  data
}

mudab_maybe_flatten <- function(data, flatten, flatten_mode) {
  if (!isTRUE(flatten)) {
    return(data)
  }

  list_cols <- names(data)[purrr::map_lgl(data, is.list)]
  bunddev_flatten_list_cols(data, cols = list_cols, mode = flatten_mode)
}

bunddev_mudab_project_stations <- function(filter = NULL,
                                           range = NULL,
                                           orderby = NULL,
                                           safe = TRUE,
                                           refresh = FALSE,
                                           flatten = FALSE,
                                           flatten_mode = "json") {
  mudab_project_stations(
    filter = filter,
    range = range,
    orderby = orderby,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_mudab_stations <- function(filter = NULL,
                                   range = NULL,
                                   orderby = NULL,
                                   safe = TRUE,
                                   refresh = FALSE) {
  mudab_stations(
    filter = filter,
    range = range,
    orderby = orderby,
    safe = safe,
    refresh = refresh
  )
}

bunddev_mudab_parameters <- function(filter = NULL,
                                     range = NULL,
                                     orderby = NULL,
                                     safe = TRUE,
                                     refresh = FALSE) {
  mudab_parameters(
    filter = filter,
    range = range,
    orderby = orderby,
    safe = safe,
    refresh = refresh
  )
}

bunddev_mudab_parameter_values <- function(filter = NULL,
                                           range = NULL,
                                           orderby = NULL,
                                           safe = TRUE,
                                           refresh = FALSE) {
  mudab_parameter_values(
    filter = filter,
    range = range,
    orderby = orderby,
    safe = safe,
    refresh = refresh
  )
}

bunddev_mudab_parameters_biologie <- function(filter = NULL,
                                              range = NULL,
                                              orderby = NULL,
                                              safe = TRUE,
                                              refresh = FALSE) {
  mudab_parameters_biologie(
    filter = filter,
    range = range,
    orderby = orderby,
    safe = safe,
    refresh = refresh
  )
}

bunddev_mudab_parameters_biota <- function(filter = NULL,
                                           range = NULL,
                                           orderby = NULL,
                                           safe = TRUE,
                                           refresh = FALSE) {
  mudab_parameters_biota(
    filter = filter,
    range = range,
    orderby = orderby,
    safe = safe,
    refresh = refresh
  )
}

bunddev_mudab_parameters_wasser <- function(filter = NULL,
                                            range = NULL,
                                            orderby = NULL,
                                            safe = TRUE,
                                            refresh = FALSE) {
  mudab_parameters_wasser(
    filter = filter,
    range = range,
    orderby = orderby,
    safe = safe,
    refresh = refresh
  )
}

bunddev_mudab_parameters_sediment <- function(filter = NULL,
                                              range = NULL,
                                              orderby = NULL,
                                              safe = TRUE,
                                              refresh = FALSE) {
  mudab_parameters_sediment(
    filter = filter,
    range = range,
    orderby = orderby,
    safe = safe,
    refresh = refresh
  )
}

bunddev_mudab_plc_stations <- function(filter = NULL,
                                       range = NULL,
                                       orderby = NULL,
                                       safe = TRUE,
                                       refresh = FALSE) {
  mudab_plc_stations(
    filter = filter,
    range = range,
    orderby = orderby,
    safe = safe,
    refresh = refresh
  )
}

bunddev_mudab_plc_parameters <- function(filter = NULL,
                                         range = NULL,
                                         orderby = NULL,
                                         safe = TRUE,
                                         refresh = FALSE) {
  mudab_plc_parameters(
    filter = filter,
    range = range,
    orderby = orderby,
    safe = safe,
    refresh = refresh
  )
}

bunddev_mudab_plc_measurements <- function(filter = NULL,
                                           range = NULL,
                                           orderby = NULL,
                                           safe = TRUE,
                                           refresh = FALSE) {
  mudab_plc_measurements(
    filter = filter,
    range = range,
    orderby = orderby,
    safe = safe,
    refresh = refresh
  )
}
