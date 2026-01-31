#' List DiGA device definitions
#'
#' @param params Query parameters.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' Returns FHIR device definitions from the DiGA directory. The API requires a
#' bearer token which can be extracted from https://diga.bfarm.de/de/verzeichnis
#' (meta name "host-app/config/environment" -> APP -> fhir -> token).
#' Official docs: https://github.com/AndreasFischer1985/diga-api.
#'
#' Configure authentication via [bunddev_auth_set()] or set the
#' `DIGA_BEARER_TOKEN` environment variable directly.
#'
#' @seealso
#' [bunddev_auth_set()] to configure authentication.
#'
#' @examples
#' \dontrun{
#' # Recommended: use bunddev_auth_set
#' Sys.setenv(DIGA_BEARER_TOKEN = "<token>")
#' bunddev_auth_set("diga", type = "api_key", env_var = "DIGA_BEARER_TOKEN", scheme = "Bearer")
#' diga_device_definitions()
#' }
#'
#' @return A tibble with FHIR entries.
#'
#' Use `bunddev_parameters("diga")` to see the currently valid parameters if
#' the API has changed.
#' @export
diga_device_definitions <- function(params = list(),
                                    safe = TRUE,
                                    refresh = FALSE,
                                    flatten = FALSE,
                                    flatten_mode = "json") {
  params <- diga_add_defaults(
    params,
    profile = "https://fhir.bfarm.de/StructureDefinition/HealthApp"
  )
  response <- diga_request(
    "/DeviceDefinition",
    params = params,
    safe = safe,
    refresh = refresh
  )

  diga_tidy_bundle(response, flatten, flatten_mode)
}

#' List DiGA catalog entries
#'
#' @param params Query parameters.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' Returns FHIR catalog entries from the DiGA directory.
#' Requires `DIGA_BEARER_TOKEN`.
#'
#' @examples
#' \dontrun{
#' diga_catalog_entries()
#' }
#'
#' @return A tibble with FHIR entries.
#'
#' Use `bunddev_parameters("diga")` to see the currently valid parameters if
#' the API has changed.
#' @export
diga_catalog_entries <- function(params = list(),
                                 safe = TRUE,
                                 refresh = FALSE,
                                 flatten = FALSE,
                                 flatten_mode = "json") {
  params <- diga_add_defaults(
    params,
    profile = "https://fhir.bfarm.de/StructureDefinition/HealthAppCatalogEntry"
  )
  response <- diga_request(
    "/CatalogEntry",
    params = params,
    safe = safe,
    refresh = refresh
  )

  diga_tidy_bundle(response, flatten, flatten_mode)
}

#' List DiGA manufacturers
#'
#' @param params Query parameters.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' Returns FHIR organization entries for manufacturers.
#' Requires `DIGA_BEARER_TOKEN`.
#'
#' @examples
#' \dontrun{
#' diga_organizations()
#' }
#'
#' @return A tibble with FHIR entries.
#'
#' Use `bunddev_parameters("diga")` to see the currently valid parameters if
#' the API has changed.
#' @export
diga_organizations <- function(params = list(),
                               safe = TRUE,
                               refresh = FALSE,
                               flatten = FALSE,
                               flatten_mode = "json") {
  params <- diga_add_defaults(
    params,
    profile = "https://fhir.bfarm.de/StructureDefinition/HealthAppManufacturer"
  )
  response <- diga_request(
    "/Organization",
    params = params,
    safe = safe,
    refresh = refresh
  )

  diga_tidy_bundle(response, flatten, flatten_mode)
}

#' List DiGA prescription units
#'
#' @param params Query parameters.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' Returns charge item definitions for prescription units.
#' Requires `DIGA_BEARER_TOKEN`.
#'
#' @examples
#' \dontrun{
#' diga_charge_item_definitions()
#' }
#'
#' @return A tibble with FHIR entries.
#'
#' Use `bunddev_parameters("diga")` to see the currently valid parameters if
#' the API has changed.
#' @export
diga_charge_item_definitions <- function(params = list(),
                                         safe = TRUE,
                                         refresh = FALSE,
                                         flatten = FALSE,
                                         flatten_mode = "json") {
  params <- diga_add_defaults(
    params,
    profile = "https://fhir.bfarm.de/StructureDefinition/HealthAppPrescriptionUnit"
  )
  response <- diga_request(
    "/ChargeItemDefinition",
    params = params,
    safe = safe,
    refresh = refresh
  )

  diga_tidy_bundle(response, flatten, flatten_mode)
}

#' List DiGA questionnaires
#'
#' @param params Query parameters.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' Returns questionnaires from the DiGA directory.
#' Requires `DIGA_BEARER_TOKEN`.
#'
#' @examples
#' \dontrun{
#' diga_questionnaires()
#' }
#'
#' @return A tibble with FHIR entries.
#'
#' Use `bunddev_parameters("diga")` to see the currently valid parameters if
#' the API has changed.
#' @export
diga_questionnaires <- function(params = list(),
                                safe = TRUE,
                                refresh = FALSE,
                                flatten = FALSE,
                                flatten_mode = "json") {
  params <- diga_add_defaults(
    params,
    profile = "https://fhir.bfarm.de/StructureDefinition/HealthAppQuestionnaire"
  )
  response <- diga_request(
    "/Questionnaire",
    params = params,
    safe = safe,
    refresh = refresh
  )

  diga_tidy_bundle(response, flatten, flatten_mode)
}

#' List DiGA questionnaire responses
#'
#' @param params Query parameters.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' Returns questionnaire responses from the DiGA directory.
#' Requires `DIGA_BEARER_TOKEN`.
#'
#' @examples
#' \dontrun{
#' diga_questionnaire_responses()
#' }
#'
#' @return A tibble with FHIR entries.
#'
#' Use `bunddev_parameters("diga")` to see the currently valid parameters if
#' the API has changed.
#' @export
diga_questionnaire_responses <- function(params = list(),
                                         safe = TRUE,
                                         refresh = FALSE,
                                         flatten = FALSE,
                                         flatten_mode = "json") {
  params <- diga_add_defaults(
    params,
    profile = "https://fhir.bfarm.de/StructureDefinition/HealthAppQuestionnaireResponse"
  )
  response <- diga_request(
    "/QuestionnaireResponse",
    params = params,
    safe = safe,
    refresh = refresh
  )

  diga_tidy_bundle(response, flatten, flatten_mode)
}

diga_add_defaults <- function(params, profile) {
  if (is.null(params$`_count`)) {
    params$`_count` <- 1000
  }
  if (is.null(params$`_profile`)) {
    params$`_profile` <- profile
  }
  params
}

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

  cache_path <- NULL
  if (isTRUE(safe)) {
    operation_id <- stringr::str_replace_all(path, "[^A-Za-z0-9]+", "_")
    cache_path <- bunddev_response_cache_path("diga", operation_id, params)
    if (!isTRUE(refresh) && file.exists(cache_path)) {
      raw_body <- readBin(cache_path, "raw", n = file.info(cache_path)$size)
      return(bunddev_parse_response(raw_body, parse))
    }
  }

  req <- httr2::request(url)
  if (length(params) > 0) {
    req <- httr2::req_url_query(req, !!!params)
  }

  # Use centralized auth - configure via bunddev_auth_set() or fall back to env var
  auth <- bunddev_auth_get("diga")
  if (auth$type == "api_key") {
    auth_value <- bunddev_auth_header("diga")
    req <- httr2::req_headers(req, Authorization = auth_value)
  } else {
    # Legacy fallback for direct env var usage
    token <- Sys.getenv("DIGA_BEARER_TOKEN")
    if (token == "") {
      cli::cli_abort(
        c("DiGA authentication not configured.",
          "i" = "Set up auth with: bunddev_auth_set(\"diga\", type = \"api_key\", env_var = \"DIGA_BEARER_TOKEN\", scheme = \"Bearer\")",
          "i" = "Or set DIGA_BEARER_TOKEN environment variable directly.")
      )
    }
    req <- httr2::req_headers(req, Authorization = paste("Bearer", token))
  }

  resp <- httr2::req_perform(req)
  raw_body <- httr2::resp_body_raw(resp)

  if (!is.null(cache_path)) {
    writeBin(raw_body, cache_path)
  }

  bunddev_parse_response(raw_body, parse)
}

diga_tidy_bundle <- function(response, flatten, flatten_mode) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  entries <- response$entry
  if (is.null(entries) || length(entries) == 0) {
    data <- tibble::tibble(bundle = list(response))
    if (flatten) {
      return(bunddev_flatten_list_cols(data, cols = "bundle", mode = flatten_mode))
    }
    return(data)
  }

  rows <- purrr::map(entries, function(entry) {
    resource <- entry$resource %||% list()
    resource
  })
  data <- dplyr::bind_rows(rows)

  if (flatten) {
    list_cols <- names(data)[purrr::map_lgl(data, is.list)]
    return(bunddev_flatten_list_cols(data, cols = list_cols, mode = flatten_mode))
  }

  data
}

bunddev_diga_device_definitions <- function(params = list(),
                                            safe = TRUE,
                                            refresh = FALSE,
                                            flatten = FALSE,
                                            flatten_mode = "json") {
  diga_device_definitions(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_diga_catalog_entries <- function(params = list(),
                                         safe = TRUE,
                                         refresh = FALSE,
                                         flatten = FALSE,
                                         flatten_mode = "json") {
  diga_catalog_entries(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_diga_organizations <- function(params = list(),
                                       safe = TRUE,
                                       refresh = FALSE,
                                       flatten = FALSE,
                                       flatten_mode = "json") {
  diga_organizations(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_diga_charge_item_definitions <- function(params = list(),
                                                 safe = TRUE,
                                                 refresh = FALSE,
                                                 flatten = FALSE,
                                                 flatten_mode = "json") {
  diga_charge_item_definitions(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_diga_questionnaires <- function(params = list(),
                                        safe = TRUE,
                                        refresh = FALSE,
                                        flatten = FALSE,
                                        flatten_mode = "json") {
  diga_questionnaires(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_diga_questionnaire_responses <- function(params = list(),
                                                 safe = TRUE,
                                                 refresh = FALSE,
                                                 flatten = FALSE,
                                                 flatten_mode = "json") {
  diga_questionnaire_responses(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}
