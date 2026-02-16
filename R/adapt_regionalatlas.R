#' Query Regionalatlas data
#'
#' @param table Table name containing indicators (e.g., "ai002_1_5" for
#'   population density). See Details for common tables.
#' @param where Optional SQL WHERE clause for filtering.
#' @param out_fields Fields to return (default "*" for all).
#' @param return_geometry Logical; include geometry in response.
#' @param params Additional ArcGIS query parameters merged with adapter defaults.
#'   Common keys:
#'   \describe{
#'     \item{layer}{JSON-encoded layer definition (set automatically from `table`).}
#'     \item{where}{SQL-like filter expression (set from `where`).}
#'     \item{outFields}{Fields to return (set from `out_fields`).}
#'     \item{returnGeometry}{Whether to include geometry (`"true"`/`"false"`).}
#'     \item{f}{Output format (`"json"` by default).}
#'     \item{spatialRel}{Spatial relation, e.g. `"esriSpatialRelIntersects"`.}
#'   }
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' The Regionalatlas API provides access to over 160 regional indicators from
#' the German statistical offices. Data is available at various administrative
#' levels (Bundeslaender, Regierungsbezirke, Kreise, Gemeinden).
#' API documentation: \url{https://github.com/bundesAPI/regionalatlas-api}.
#'
#' Common tables and their indicators:
#' - `ai002_1_5`: Population (ai0201=density, ai0202=change, ai0208=foreigners %)
#' - `ai002_4_5`: Age (ai0218=average age, ai0219=mother age at 1st child)
#' - `ai008_1_5`: Employment (ai0801=unemployment rate)
#' - `ai_s_01`: Disposable income per capita
#' - `ai_s_04`: SGB-II quota
#' - `ai017_1`: GDP per employee
#' - `ai005`: Federal election results
#'
#' Regional levels in data: typ 1=Bundeslaender, 2=Regierungsbezirke, 3=Kreise,
#' 5=Gemeinden. Filter using WHERE clause, e.g., `where = "typ = 1"`.
#'
#' @seealso
#' [bunddev_parameters()] for available query parameters.
#'
#' @examples
#' \dontrun{
#' # Population density indicators
#' regionalatlas_query("ai002_1_5")
#'
#' # Filter for Bundeslaender only
#' regionalatlas_query("ai002_1_5", where = "typ = 1")
#'
#' # Age data for Kreise
#' regionalatlas_query("ai002_4_5", where = "typ = 3")
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per geographic feature and columns:
#'   \describe{
#'     \item{ags}{Character. Official municipality key (Amtlicher Gemeindeschluessel).}
#'     \item{ags2}{Character. Join key for indicator tables.}
#'     \item{gen}{Character. Region name.}
#'     \item{typ}{Integer. Administrative level (1=Bundeslaender, 2=Regierungsbezirke, 3=Kreise, 5=Gemeinden).}
#'     \item{jahr}{Integer. Reference year.}
#'     \item{jahr2}{Integer. Indicator reference year.}
#'     \item{ai...}{Numeric. Indicator values whose names depend on the selected table (e.g. `ai0201` for population density).}
#'   }
#' @family Regionalatlas
#' @export
regionalatlas_query <- function(table,
                                where = "1=1",
                                out_fields = "*",
                                return_geometry = FALSE,
                                params = list(),
                                safe = TRUE,
                                refresh = FALSE) {
  if (is.null(table) || table == "") {
    cli::cli_abort("table is required.")
  }

  # Build the layer parameter as required by ArcGIS
  layer_json <- list(
    source = list(
      type = "dataLayer",
      dataSource = list(
        type = "table",
        workspaceId = "gdb",
        dataSourceName = paste0("regionalatlas.", table)
      )
    )
  )

  params$layer <- jsonlite::toJSON(layer_json, auto_unbox = TRUE)
  params$where <- where
  params$outFields <- out_fields
  params$returnGeometry <- tolower(as.character(return_geometry))
  params$f <- "json"

  response <- bunddev_call(
    "regionalatlas",
    "query",
    params = params,
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  regionalatlas_tidy_response(response)
}

regionalatlas_tidy_response <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  if (!is.null(response$error)) {
    cli::cli_warn("API error: {response$error$message %||% 'Unknown error'}")
    return(tibble::tibble())
  }

  features <- response$features
  if (is.null(features) || length(features) == 0) {
    return(tibble::tibble())
  }

  rows <- purrr::map(features, function(feature) {
    attrs <- feature$attributes %||% list()
    tibble::as_tibble(purrr::map(attrs, ~ if (is.null(.x)) NA else .x))
  })

  dplyr::bind_rows(rows)
}

bunddev_regionalatlas_query <- function(table,
                                        where = "1=1",
                                        out_fields = "*",
                                        return_geometry = FALSE,
                                        params = list(),
                                        safe = TRUE,
                                        refresh = FALSE) {
  regionalatlas_query(
    table = table,
    where = where,
    out_fields = out_fields,
    return_geometry = return_geometry,
    params = params,
    safe = safe,
    refresh = refresh
  )
}
