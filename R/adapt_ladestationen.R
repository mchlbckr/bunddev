#' Query charging stations
#'
#' @param params Query parameters for the ArcGIS service.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' The Ladesaeulenregister API is backed by an ArcGIS feature service. You must
#' supply a `geometry` filter and `outFields`. The ArcGIS service may require a
#' `token` query parameter even though the API docs describe the service as
#' public. Official docs:
#' https://ladestationen.api.bund.dev.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#'
#' @examples
#' \dontrun{
#' geometry <- jsonlite::toJSON(
#'   list(
#'     xmin = 13.3, ymin = 52.4, xmax = 13.5, ymax = 52.6,
#'     spatialReference = list(wkid = 4326)
#'   ),
#'   auto_unbox = TRUE
#' )
#' ladestationen_query(params = list(
#'   geometry = geometry,
#'   geometryType = "esriGeometryEnvelope",
#'   where = "1=1",
#'   outFields = "*",
#'   outSR = 4326,
#'   f = "json",
#'   returnGeometry = "false",
#'   resultRecordCount = 5
#' ))
#' }
#'
#' @return A tibble with charging station records.
#'
#' Use `bunddev_parameters("ladestationen")` to see the currently valid parameters
#' if the API has changed.
#' @export
ladestationen_query <- function(params = list(),
                                safe = TRUE,
                                refresh = FALSE,
                                flatten = FALSE,
                                flatten_mode = "json") {
  if (is.null(params$geometry)) {
    cli::cli_abort("'geometry' is required for ladestationen_query().")
  }
  if (is.null(params$outFields)) {
    params$outFields <- "*"
  }
  if (is.null(params$f)) {
    params$f <- "json"
  }

  if (is.list(params$geometry)) {
    params$geometry <- jsonlite::toJSON(params$geometry, auto_unbox = TRUE)
  }

  response <- ladestationen_request(params, safe = safe, refresh = refresh)
  data <- ladestationen_tidy_response(response)

  if (flatten) {
    return(bunddev_flatten_list_cols(data, cols = c("geometry"), mode = flatten_mode))
  }

  data
}

    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}
