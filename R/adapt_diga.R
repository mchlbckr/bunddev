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
#' @return A [tibble][tibble::tibble] with one row per device definition and columns:
#'   \describe{
#'     \item{resourceType}{Character. FHIR resource type, always `"DeviceDefinition"`.}
#'     \item{id}{Character. FHIR resource identifier.}
#'     \item{url}{Character. Canonical URL of the resource.}
#'     \item{status}{Character. Publication status.}
#'     \item{description}{Character. Device description text.}
#'     \item{meta}{List. Resource metadata (profile, timestamps).}
#'     \item{identifier}{List. Business identifiers.}
#'     \item{type}{List. Device type coding.}
#'     \item{deviceName}{List. Device name entries.}
#'     \item{property}{List. Device properties.}
#'     \item{extension}{List. FHIR profile extensions.}
#'   }
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
#' @return A [tibble][tibble::tibble] with one row per catalog entry and columns:
#'   \describe{
#'     \item{resourceType}{Character. FHIR resource type, always `"CatalogEntry"`.}
#'     \item{id}{Character. FHIR resource identifier.}
#'     \item{status}{Character. Entry status.}
#'     \item{orderable}{Logical. Whether the entry is orderable.}
#'     \item{meta}{List. Resource metadata (profile, timestamps).}
#'     \item{identifier}{List. Business identifiers.}
#'     \item{type}{List. Catalog entry type coding.}
#'     \item{referencedItem}{List. Referenced device definition.}
#'     \item{extension}{List. FHIR profile extensions.}
#'     \item{additionalCharacteristic}{List. Additional characteristics.}
#'   }
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
#' @return A [tibble][tibble::tibble] with one row per organization and columns:
#'   \describe{
#'     \item{resourceType}{Character. FHIR resource type, always `"Organization"`.}
#'     \item{id}{Character. FHIR resource identifier.}
#'     \item{name}{Character. Organization display name.}
#'     \item{active}{Logical. Whether the organization is active.}
#'     \item{meta}{List. Resource metadata (profile, timestamps).}
#'     \item{identifier}{List. Business identifiers.}
#'     \item{type}{List. Organization type coding.}
#'     \item{telecom}{List. Contact details.}
#'     \item{address}{List. Postal addresses.}
#'     \item{extension}{List. FHIR profile extensions.}
#'   }
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
#' @return A [tibble][tibble::tibble] with one row per charge item definition and columns:
#'   \describe{
#'     \item{resourceType}{Character. FHIR resource type, always `"ChargeItemDefinition"`.}
#'     \item{id}{Character. FHIR resource identifier.}
#'     \item{url}{Character. Canonical URL of the resource.}
#'     \item{status}{Character. Publication status.}
#'     \item{description}{Character. Description text.}
#'     \item{meta}{List. Resource metadata (profile, timestamps).}
#'     \item{identifier}{List. Business identifiers.}
#'     \item{code}{List. Charge item code.}
#'     \item{instance}{List. Referenced device definitions.}
#'     \item{applicability}{List. Applicability conditions.}
#'     \item{propertyGroup}{List. Pricing properties.}
#'     \item{extension}{List. FHIR profile extensions.}
#'   }
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
#' @return A [tibble][tibble::tibble] with one row per questionnaire and columns:
#'   \describe{
#'     \item{resourceType}{Character. FHIR resource type, always `"Questionnaire"`.}
#'     \item{id}{Character. FHIR resource identifier.}
#'     \item{url}{Character. Canonical URL of the resource.}
#'     \item{status}{Character. Publication status.}
#'     \item{name}{Character. Computer-friendly name.}
#'     \item{title}{Character. Human-readable title.}
#'     \item{meta}{List. Resource metadata (profile, timestamps).}
#'     \item{identifier}{List. Business identifiers.}
#'     \item{item}{List. Questionnaire items and groups.}
#'     \item{extension}{List. FHIR profile extensions.}
#'   }
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
#' @return A [tibble][tibble::tibble] with one row per questionnaire response and columns:
#'   \describe{
#'     \item{resourceType}{Character. FHIR resource type, always `"QuestionnaireResponse"`.}
#'     \item{id}{Character. FHIR resource identifier.}
#'     \item{status}{Character. Response completion status.}
#'     \item{authored}{Character. When the response was authored.}
#'     \item{meta}{List. Resource metadata (profile, timestamps).}
#'     \item{identifier}{List. Business identifiers.}
#'     \item{questionnaire}{Character. Reference to source questionnaire.}
#'     \item{item}{List. Response items and answers.}
#'     \item{extension}{List. FHIR profile extensions.}
#'   }
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
