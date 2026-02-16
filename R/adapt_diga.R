#' DiGA API adapters
#'
#' Functions to call the DiGA API endpoints.
#'
#' @keywords internal
#' @name adapt_diga
NULL

#' List DiGA device definitions
#'
#' @param params Named list of FHIR search parameters:
#'   \describe{
#'     \item{`_count`}{Maximum bundle size per request (integer, default `1000`).}
#'     \item{`_profile`}{FHIR profile URL used to restrict resource type (character).}
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
#' @return A tibble with one row per FHIR resource in the returned bundle.
#' Column structure depends on the resource profile and may include nested
#' list-columns when `flatten = FALSE`.
#'
#'
#' \describe{
#'   \item{Scalar fields}{One column per top-level scalar field returned by the endpoint.}
#'   \item{Nested fields}{Kept as list-columns; for endpoints with `flatten` controls these can be transformed.}
#' }
#' @family DiGA
#' @export
#' @examples
#' \dontrun{dig_device_definitions()}

diga_device_definitions <- function(params = list(), safe = TRUE, refresh = FALSE, flatten = FALSE, flatten_mode = "json") {
  params <- diga_add_defaults(params, profile = "https://fhir.bfarm.de/StructureDefinition/HealthApp")
  response <- diga_request("/DeviceDefinition", params = params, safe = safe, refresh = refresh)
  diga_tidy_bundle(response, flatten, flatten_mode)
}

#' List DiGA catalog entries
#'
#' @inheritParams diga_device_definitions
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
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @return A tibble with one row per catalog entry resource (same structure
#' rules as [diga_device_definitions()]).
#'
#' \describe{
#'   \item{Resource fields}{One column per top-level scalar field in each FHIR `entry$resource`.}
#'   \item{Nested resource fields}{Stored as list-columns.}
#'   \item{bundle}{Returned as list-column when the response has no `entry` records.}
#' }
#' @family DiGA
#' @export

diga_catalog_entries <- function(params = list(), safe = TRUE, refresh = FALSE, flatten = FALSE, flatten_mode = "json") {
  params <- diga_add_defaults(params, profile = "https://fhir.bfarm.de/StructureDefinition/HealthAppCatalogEntry")
  response <- diga_request("/CatalogEntry", params = params, safe = safe, refresh = refresh)
  diga_tidy_bundle(response, flatten, flatten_mode)
}

#' List DiGA manufacturers
#'
#' @inheritParams diga_device_definitions
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
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @return A tibble with one row per organization resource (same structure rules
#' as [diga_device_definitions()]).
#'
#' \describe{
#'   \item{Resource fields}{One column per top-level scalar field in each FHIR `entry$resource`.}
#'   \item{Nested resource fields}{Stored as list-columns.}
#'   \item{bundle}{Returned as list-column when the response has no `entry` records.}
#' }
#' @family DiGA
#' @export

diga_organizations <- function(params = list(), safe = TRUE, refresh = FALSE, flatten = FALSE, flatten_mode = "json") {
  params <- diga_add_defaults(params, profile = "https://fhir.bfarm.de/StructureDefinition/HealthAppManufacturer")
  response <- diga_request("/Organization", params = params, safe = safe, refresh = refresh)
  diga_tidy_bundle(response, flatten, flatten_mode)
}

#' List DiGA prescription units
#'
#' @inheritParams diga_device_definitions
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
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @return A tibble with one row per charge item definition resource (same
#' structure rules as [diga_device_definitions()]).
#'
#' \describe{
#'   \item{Resource fields}{One column per top-level scalar field in each FHIR `entry$resource`.}
#'   \item{Nested resource fields}{Stored as list-columns.}
#'   \item{bundle}{Returned as list-column when the response has no `entry` records.}
#' }
#' @family DiGA
#' @export

diga_charge_item_definitions <- function(params = list(), safe = TRUE, refresh = FALSE, flatten = FALSE, flatten_mode = "json") {
  params <- diga_add_defaults(params, profile = "https://fhir.bfarm.de/StructureDefinition/HealthAppPrescriptionUnit")
  response <- diga_request("/ChargeItemDefinition", params = params, safe = safe, refresh = refresh)
  diga_tidy_bundle(response, flatten, flatten_mode)
}

#' List DiGA questionnaires
#'
#' @inheritParams diga_device_definitions
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
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @return A tibble with one row per questionnaire resource (same structure
#' rules as [diga_device_definitions()]).
#'
#' \describe{
#'   \item{Resource fields}{One column per top-level scalar field in each FHIR `entry$resource`.}
#'   \item{Nested resource fields}{Stored as list-columns.}
#'   \item{bundle}{Returned as list-column when the response has no `entry` records.}
#' }
#' @family DiGA
#' @export

diga_questionnaires <- function(params = list(), safe = TRUE, refresh = FALSE, flatten = FALSE, flatten_mode = "json") {
  params <- diga_add_defaults(params, profile = "https://fhir.bfarm.de/StructureDefinition/HealthAppQuestionnaire")
  response <- diga_request("/Questionnaire", params = params, safe = safe, refresh = refresh)
  diga_tidy_bundle(response, flatten, flatten_mode)
}

#' List DiGA questionnaire responses
#'
#' @inheritParams diga_device_definitions
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
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @return A tibble with one row per questionnaire response resource (same
#' structure rules as [diga_device_definitions()]).
#'
#' \describe{
#'   \item{Resource fields}{One column per top-level scalar field in each FHIR `entry$resource`.}
#'   \item{Nested resource fields}{Stored as list-columns.}
#'   \item{bundle}{Returned as list-column when the response has no `entry` records.}
#' }
#' @family DiGA
#' @export

diga_questionnaire_responses <- function(params = list(), safe = TRUE, refresh = FALSE, flatten = FALSE, flatten_mode = "json") {
  params <- diga_add_defaults(params, profile = "https://fhir.bfarm.de/StructureDefinition/HealthAppQuestionnaireResponse")
  response <- diga_request("/QuestionnaireResponse", params = params, safe = safe, refresh = refresh)
  diga_tidy_bundle(response, flatten, flatten_mode)
}

# Helper to add default parameters

diga_add_defaults <- function(params, profile) {
  if (is.null(params$`_count`)) params$`_count` <- 1000
  if (is.null(params$`_profile`)) params$`_profile` <- profile
  params
}

# Core request function – delegates to bunddev_call

diga_request <- function(path, params, safe = TRUE, refresh = FALSE, parse = "json") {
  bunddev_call(
    "diga",
    path = path,
    method = "GET",
    params = params,
    parse = parse,
    safe = safe,
    refresh = refresh
  )
}

# Tidy helper – transforms FHIR bundle into tibble

diga_tidy_bundle <- function(response, flatten, flatten_mode) {
  if (is.null(response) || length(response) == 0) return(tibble::tibble())
  entries <- response$entry
  if (is.null(entries) || length(entries) == 0) {
    data <- tibble::tibble(bundle = list(response))
    if (flatten) {
      return(bunddev_flatten_list_cols(data, cols = "bundle", mode = flatten_mode))
    }
    return(data)
  }
  rows <- purrr::map(entries, function(entry) entry$resource %||% list())
  data <- dplyr::bind_rows(rows)
  if (flatten) {
    list_cols <- names(data)[purrr::map_lgl(data, is.list)]
    return(bunddev_flatten_list_cols(data, cols = list_cols, mode = flatten_mode))
  }
  data
}

# Wrapper functions to expose via package namespace

bunddev_diga_device_definitions <- function(params = list(), safe = TRUE, refresh = FALSE, flatten = FALSE, flatten_mode = "json") {
  diga_device_definitions(params = params, safe = safe, refresh = refresh, flatten = flatten, flatten_mode = flatten_mode)
}

bunddev_diga_catalog_entries <- function(params = list(), safe = TRUE, refresh = FALSE, flatten = FALSE, flatten_mode = "json") {
  diga_catalog_entries(params = params, safe = safe, refresh = refresh, flatten = flatten, flatten_mode = flatten_mode)
}

bunddev_diga_organizations <- function(params = list(), safe = TRUE, refresh = FALSE, flatten = FALSE, flatten_mode = "json") {
  diga_organizations(params = params, safe = safe, refresh = refresh, flatten = flatten, flatten_mode = flatten_mode)
}

bunddev_diga_charge_item_definitions <- function(params = list(), safe = TRUE, refresh = FALSE, flatten = FALSE, flatten_mode = "json") {
  diga_charge_item_definitions(params = params, safe = safe, refresh = refresh, flatten = flatten, flatten_mode = flatten_mode)
}

bunddev_diga_questionnaires <- function(params = list(), safe = TRUE, refresh = FALSE, flatten = FALSE, flatten_mode = "json") {
  diga_questionnaires(params = params, safe = safe, refresh = refresh, flatten = flatten, flatten_mode = flatten_mode)
}

bunddev_diga_questionnaire_responses <- function(params = list(), safe = TRUE, refresh = FALSE, flatten = FALSE, flatten_mode = "json") {
  diga_questionnaire_responses(params = params, safe = safe, refresh = refresh, flatten = flatten, flatten_mode = flatten_mode)
}
