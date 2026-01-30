#' List OpenAPI endpoints for an API
#'
#' @param id Registry id.
#'
#' @details
#' Parses the cached OpenAPI spec and returns every available path + method with
#' its operationId and summary, if provided.
#'
#' @seealso
#' [bunddev_parameters()] to inspect parameters and [bunddev_spec()] to access
#' the full spec.
#'
#' @examples
#' bunddev_endpoints("autobahn")
#'
#' @return A tibble with endpoints.
#' @export
bunddev_endpoints <- function(id) {
  spec <- bunddev_spec(id)
  paths <- spec$paths

  if (is.null(paths) || length(paths) == 0) {
    cli::cli_abort("OpenAPI spec has no paths.")
  }

  endpoints <- purrr::imap_dfr(paths, function(path_item, path) {
    if (!is.list(path_item)) {
      return(tibble::tibble())
    }

    methods <- names(path_item)
    purrr::map_dfr(methods, function(method) {
      operation <- path_item[[method]]
      if (!is.list(operation)) {
        return(tibble::tibble())
      }

      operation_id <- if (is.null(operation$operationId)) NA_character_ else operation$operationId
      summary <- if (is.null(operation$summary)) NA_character_ else operation$summary

      tibble::tibble(
        method = method,
        path = path,
        operation_id = operation_id,
        summary = summary
      )
    })
  })

  if (nrow(endpoints) == 0) {
    cli::cli_abort("No endpoints found in the OpenAPI spec.")
  }

  endpoints
}

#' List OpenAPI parameters for an API
#'
#' @param id Registry id.
#' @param name Optional parameter name to filter.
#' @param path Optional endpoint path to filter.
#' @param method Optional HTTP method to filter.
#'
#' @details
#' Returns one row per parameter defined in the OpenAPI spec. Enumerations are
#' stored in a list-column (`enum`). Use the filter arguments to narrow down
#' results to a specific endpoint or parameter name.
#'
#' @seealso
#' [bunddev_parameters_for()] for adapter-specific parameters and
#' [bunddev_parameter_values()] for enum values.
#'
#' @examples
#' bunddev_parameters("smard", name = "resolution")
#'
#' @return A tibble with parameter metadata.
#' @export
bunddev_parameters <- function(id, name = NULL, path = NULL, method = NULL) {
  spec <- bunddev_spec(id)
  paths <- spec$paths

  if (is.null(paths) || length(paths) == 0) {
    cli::cli_abort("OpenAPI spec has no paths.")
  }

  params <- purrr::imap_dfr(paths, function(path_item, path) {
    if (!is.list(path_item)) {
      return(tibble::tibble())
    }

    path_params <- path_item$parameters %||% list()
    methods <- setdiff(names(path_item), "parameters")

    purrr::map_dfr(methods, function(method) {
      operation <- path_item[[method]]
      op_params <- operation$parameters %||% list()
      combined <- c(path_params, op_params)

      if (length(combined) == 0) {
        return(tibble::tibble())
      }

      purrr::map_dfr(combined, function(param) {
        resolved <- bunddev_resolve_parameter(param, spec)
        if (is.null(resolved)) {
          return(tibble::tibble())
        }

        schema <- resolved$schema %||% list()
        tibble::tibble(
          method = method,
          path = path,
          name = resolved$name %||% NA_character_,
          location = resolved$`in` %||% NA_character_,
          required = isTRUE(resolved$required),
          description = resolved$description %||% NA_character_,
          schema_type = schema$type %||% NA_character_,
          enum = list(schema$enum %||% character())
        )
      })
    })
  })

  if (nrow(params) == 0) {
    cli::cli_abort("No parameters found in the OpenAPI spec.")
  }

  if (!is.null(name)) {
    params <- dplyr::filter(params, .data$name == name)
  }
  if (!is.null(path)) {
    params <- dplyr::filter(params, .data$path == path)
  }
  if (!is.null(method)) {
    params <- dplyr::filter(params, .data$method == method)
  }

  params
}

bunddev_resolve_parameter <- function(param, spec) {
  if (is.null(param)) {
    return(NULL)
  }
  ref <- param$`$ref`
  if (!is.null(ref)) {
    name <- stringr::str_replace(ref, "^#/components/parameters/", "")
    if (!is.null(spec$components$parameters[[name]])) {
      return(spec$components$parameters[[name]])
    }
    return(NULL)
  }
  param
}

#' Extract parameter enum values
#'
#' @param endpoint Adapter function or its name.
#' @param name Parameter name.
#'
#' @details
#' Returns unique enum values for a parameter defined on the adapter endpoint.
#'
#' @seealso
#' [bunddev_parameters_for()] to inspect all parameters for an adapter.
#'
#' @examples
#' bunddev_parameter_values(smard_timeseries, "resolution")
#'
#' @return A character vector of enum values.
#' @export
bunddev_parameter_values <- function(endpoint, name) {
  endpoint_name <- bunddev_endpoint_name(endpoint)
  spec <- bunddev_endpoint_spec(endpoint_name)
  params <- bunddev_parameters(
    spec$api,
    name = name,
    path = spec$path,
    method = spec$method
  )
  enums <- purrr::map(params$enum, ~ as.character(.x))
  unique(unlist(enums))
}

#' List OpenAPI parameters for a specific adapter
#'
#' @param endpoint Adapter function or its name.
#'
#' @details
#' Resolves the adapter to an OpenAPI path/method mapping and filters parameters
#' accordingly.
#'
#' @seealso
#' [bunddev_parameters()] for the full API parameter table.
#'
#' @examples
#' bunddev_parameters_for(smard_timeseries)
#'
#' @return A tibble with parameter metadata.
#' @export
bunddev_parameters_for <- function(endpoint) {
  endpoint_name <- bunddev_endpoint_name(endpoint)
  spec <- bunddev_endpoint_spec(endpoint_name)
  bunddev_parameters(spec$api, path = spec$path, method = spec$method)
}

bunddev_endpoint_name <- function(endpoint) {
  if (is.character(endpoint) && length(endpoint) == 1) {
    return(endpoint)
  }

  name <- deparse(substitute(endpoint))
  if (!identical(name, "endpoint")) {
    return(name)
  }

  if (is.function(endpoint)) {
    name <- deparse(substitute(endpoint, parent.frame()))
    return(name)
  }

  "endpoint"
}

bunddev_endpoint_spec <- function(endpoint) {
  spec <- bunddev_endpoint_map()[[endpoint]]
  if (is.null(spec)) {
    cli::cli_abort("No endpoint mapping found for '{endpoint}'.")
  }
  spec
}

bunddev_endpoint_map <- function() {
  list(
    smard_indices = list(
      api = "smard",
      path = "/chart_data/{filter}/{region}/index_{resolution}.json",
      method = "get"
    ),
    smard_timeseries = list(
      api = "smard",
      path = "/chart_data/{filter}/{region}/{filterCopy}_{regionCopy}_{resolution}_{timestamp}.json",
      method = "get"
    ),
    smard_table = list(
      api = "smard",
      path = "/table_data/{filter}/{region}/{filterCopy}_{regionCopy}_quarterhour_{timestamp}.json",
      method = "get"
    ),
    dwd_station_overview = list(
      api = "dwd",
      path = "/stationOverviewExtended",
      method = "get"
    ),
    dwd_crowd_reports = list(
      api = "dwd",
      path = "/crowd_meldungen_overview_v2.json",
      method = "get"
    ),
    dwd_warnings_nowcast = list(
      api = "dwd",
      path = "/warnings_nowcast.json",
      method = "get"
    ),
    dwd_municipality_warnings = list(
      api = "dwd",
      path = "/gemeinde_warnings_v2.json",
      method = "get"
    ),
    dwd_coast_warnings = list(
      api = "dwd",
      path = "/warnings_coast.json",
      method = "get"
    ),
    jobsuche_search = list(
      api = "jobsuche",
      path = "/pc/v4/jobs",
      method = "get"
    ),
    jobsuche_search_app = list(
      api = "jobsuche",
      path = "/pc/v4/app/jobs",
      method = "get"
    ),
    jobsuche_logo = list(
      api = "jobsuche",
      path = "/ed/v1/arbeitgeberlogo/{hashID}",
      method = "get"
    ),
    tagesschau_homepage = list(
      api = "tagesschau",
      path = "/homepage",
      method = "get"
    ),
    tagesschau_news = list(
      api = "tagesschau",
      path = "/news",
      method = "get"
    ),
    tagesschau_search = list(
      api = "tagesschau",
      path = "/search",
      method = "get"
    ),
    tagesschau_channels = list(
      api = "tagesschau",
      path = "/channels",
      method = "get"
    ),
    autobahn_roads = list(
      api = "autobahn",
      path = "/autobahnen",
      method = "get"
    ),
    autobahn_roadworks = list(
      api = "autobahn",
      path = "/autobahn/{roadId}/services/roadworks",
      method = "get"
    ),
    autobahn_warnings = list(
      api = "autobahn",
      path = "/autobahn/{roadId}/services/warning",
      method = "get"
    ),
    autobahn_webcams = list(
      api = "autobahn",
      path = "/autobahn/{roadId}/services/webcam",
      method = "get"
    ),
    autobahn_closures = list(
      api = "autobahn",
      path = "/autobahn/{roadId}/services/closure",
      method = "get"
    ),
    autobahn_charging_stations = list(
      api = "autobahn",
      path = "/autobahn/{roadId}/services/charging_station",
      method = "get"
    ),
    autobahn_parking_lorries = list(
      api = "autobahn",
      path = "/autobahn/{roadId}/services/parking_lorry",
      method = "get"
    ),
    bewerberboerse_search = list(
      api = "bewerberboerse",
      path = "/pc/v1/bewerber",
      method = "get"
    ),
    bewerberboerse_details = list(
      api = "bewerberboerse",
      path = "/pc/v1/bewerber/{referenznummer}",
      method = "get"
    ),
    feiertage_list = list(
      api = "feiertage",
      path = "/",
      method = "get"
    ),
    lebensmittelwarnung_warnings = list(
      api = "lebensmittelwarnung",
      path = "/warnings/merged",
      method = "post"
    ),
    pegel_online_stations = list(
      api = "pegel_online",
      path = "/stations.json",
      method = "get"
    ),
    pegel_online_station = list(
      api = "pegel_online",
      path = "/stations/{station}.json",
      method = "get"
    ),
    pegel_online_waters = list(
      api = "pegel_online",
      path = "/waters.json",
      method = "get"
    ),
    pegel_online_timeseries = list(
      api = "pegel_online",
      path = "/stations/{station}/{timeseries}.json",
      method = "get"
    ),
    pegel_online_measurements = list(
      api = "pegel_online",
      path = "/stations/{station}/{timeseries}/measurements.json",
      method = "get"
    ),
    bundeshaushalt_budget_data = list(
      api = "bundeshaushalt",
      path = "/internalapi/budgetData",
      method = "get"
    ),
    dashboard_deutschland_get = list(
      api = "dashboard_deutschland",
      path = "/api/dashboard/get",
      method = "get"
    ),
    dashboard_deutschland_indicators = list(
      api = "dashboard_deutschland",
      path = "/api/tile/indicators",
      method = "get"
    ),
    dashboard_deutschland_geo = list(
      api = "dashboard_deutschland",
      path = "/geojson/de-all.geo.json",
      method = "get"
    ),
    entgeltatlas_entgelte = list(
      api = "entgeltatlas",
      path = "/pc/v1/entgelte/{kldb}",
      method = "get"
    ),
    bundesrat_startlist = list(
      api = "bundesrat",
      path = "/iOS/v3/startlist_table.xml",
      method = "get"
    ),
    bundesrat_aktuelles = list(
      api = "bundesrat",
      path = "/iOS/v3/01_Aktuelles/aktuelles_table.xml",
      method = "get"
    ),
    bundesrat_termine = list(
      api = "bundesrat",
      path = "/iOS/v3/02_Termine/termine_table.xml",
      method = "get"
    ),
    bundesrat_plenum_kompakt = list(
      api = "bundesrat",
      path = "/iOS/v3/03_Plenum/plenum_kompakt_table.xml",
      method = "get"
    ),
    bundesrat_plenum_aktuelle_sitzung = list(
      api = "bundesrat",
      path = "/iOS/SharedDocs/3_Plenum/plenum_aktuelleSitzung_table.xml",
      method = "get"
    ),
    bundesrat_plenum_chronologisch = list(
      api = "bundesrat",
      path = "/iOS/SharedDocs/3_Plenum/plenum_toChronologisch_table.xml",
      method = "get"
    ),
    bundesrat_plenum_naechste_sitzungen = list(
      api = "bundesrat",
      path = "/iOS/SharedDocs/3_Plenum/plenum_naechsteSitzungen.xml",
      method = "get"
    ),
    bundesrat_mitglieder = list(
      api = "bundesrat",
      path = "/iOS/SharedDocs/2_Mitglieder/mitglieder_table.xml",
      method = "get"
    ),
    bundesrat_stimmverteilung = list(
      api = "bundesrat",
      path = "/iOS/v3/06_Stimmen/stimmverteilung.xml",
      method = "get"
    ),
    bundesrat_praesidium = list(
      api = "bundesrat",
      path = "/iOS/v3/05_Bundesrat/Praesidium/bundesrat_praesidium.xml",
      method = "get"
    ),
    hochwasserzentralen_pegel_info = list(
      api = "hochwasserzentralen",
      path = "/webservices/get_infospegel.php",
      method = "post"
    ),
    hochwasserzentralen_bundeslaender = list(
      api = "hochwasserzentralen",
      path = "/webservices/get_infosbundesland.php",
      method = "get"
    ),
    hochwasserzentralen_bundesland_info = list(
      api = "hochwasserzentralen",
      path = "/webservices/get_infosbundesland.php",
      method = "post"
    ),
    hochwasserzentralen_lagepegel = list(
      api = "hochwasserzentralen",
      path = "/webservices/get_lagepegel.php",
      method = "get"
    ),
    hochwasserzentralen_bundesland_geojson = list(
      api = "hochwasserzentralen",
      path = "/vhosts/geojson/bundesland.{version}.geojson",
      method = "get"
    ),
    luftqualitaet_airquality = list(
      api = "luftqualitaet",
      path = "/airquality/json",
      method = "get"
    ),
    luftqualitaet_airquality_limits = list(
      api = "luftqualitaet",
      path = "/airquality/limits",
      method = "get"
    ),
    luftqualitaet_annualbalances = list(
      api = "luftqualitaet",
      path = "/annualbalances/json",
      method = "get"
    ),
    luftqualitaet_components = list(
      api = "luftqualitaet",
      path = "/components/json",
      method = "get"
    ),
    luftqualitaet_measures = list(
      api = "luftqualitaet",
      path = "/measures/json",
      method = "get"
    ),
    luftqualitaet_measures_limits = list(
      api = "luftqualitaet",
      path = "/measures/limits",
      method = "get"
    ),
    luftqualitaet_networks = list(
      api = "luftqualitaet",
      path = "/networks/json",
      method = "get"
    ),
    luftqualitaet_scopes = list(
      api = "luftqualitaet",
      path = "/scopes/json",
      method = "get"
    ),
    luftqualitaet_stationsettings = list(
      api = "luftqualitaet",
      path = "/stationsettings/json",
      method = "get"
    ),
    luftqualitaet_stationtypes = list(
      api = "luftqualitaet",
      path = "/stationtypes/json",
      method = "get"
    ),
    luftqualitaet_thresholds = list(
      api = "luftqualitaet",
      path = "/thresholds/json",
      method = "get"
    ),
    luftqualitaet_transgressions = list(
      api = "luftqualitaet",
      path = "/transgressions/json",
      method = "get"
    ),
    luftqualitaet_transgressiontypes = list(
      api = "luftqualitaet",
      path = "/transgressiontypes/json",
      method = "get"
    ),
    luftqualitaet_meta = list(
      api = "luftqualitaet",
      path = "/meta/json",
      method = "get"
    ),
    travelwarning_warnings = list(
      api = "travelwarning",
      path = "/travelwarning",
      method = "get"
    ),
    travelwarning_warning = list(
      api = "travelwarning",
      path = "/travelwarning/{contentId}",
      method = "get"
    ),
    travelwarning_representatives_germany = list(
      api = "travelwarning",
      path = "/representativesInGermany",
      method = "get"
    ),
    travelwarning_representatives_country = list(
      api = "travelwarning",
      path = "/representativesInCountry",
      method = "get"
    ),
    travelwarning_state_names = list(
      api = "travelwarning",
      path = "/stateNames",
      method = "get"
    ),
    travelwarning_healthcare = list(
      api = "travelwarning",
      path = "/healthcare",
      method = "get"
    ),
    ladestationen_query = list(
      api = "ladestationen",
      path = "/query",
      method = "get"
    ),
    nina_warnings = list(
      api = "nina",
      path = "/travelwarning",
      method = "get"
    ),
    nina_warning = list(
      api = "nina",
      path = "/travelwarning/{contentId}",
      method = "get"
    ),
    nina_warning_json = list(
      api = "nina",
      path = "/warnings/{identifier}.json",
      method = "get"
    ),
    nina_warning_geojson = list(
      api = "nina",
      path = "/warnings/{identifier}.geojson",
      method = "get"
    ),
    nina_dashboard = list(
      api = "nina",
      path = "/dashboard/{ARS}.json",
      method = "get"
    ),
    nina_covid_rules = list(
      api = "nina",
      path = "/appdata/covid/covidrules/DE/{ARS}.json",
      method = "get"
    ),
    nina_covid_infos = list(
      api = "nina",
      path = "/appdata/covid/covidinfos/DE/covidinfos.json",
      method = "get"
    ),
    nina_covid_ticker = list(
      api = "nina",
      path = "/appdata/covid/covidticker/DE/covidticker.json",
      method = "get"
    ),
    nina_covid_ticker_message = list(
      api = "nina",
      path = "/appdata/covid/covidticker/DE/tickermeldungen/{id}.json",
      method = "get"
    ),
    nina_covid_map = list(
      api = "nina",
      path = "/appdata/covid/covidmap/DE/covidmap.json",
      method = "get"
    ),
    nina_logos = list(
      api = "nina",
      path = "/appdata/gsb/logos/logos.json",
      method = "get"
    ),
    nina_logo = list(
      api = "nina",
      path = "/appdata/gsb/logos/{filename}",
      method = "get"
    ),
    nina_event_codes = list(
      api = "nina",
      path = "/appdata/gsb/eventCodes/eventCodes.json",
      method = "get"
    ),
    nina_event_code = list(
      api = "nina",
      path = "/appdata/gsb/eventCodes/{filename}",
      method = "get"
    ),
    nina_notfalltipps = list(
      api = "nina",
      path = "/appdata/gsb/notfalltipps/DE/notfalltipps.json",
      method = "get"
    ),
    nina_faqs = list(
      api = "nina",
      path = "/appdata/gsb/faqs/DE/faq.json",
      method = "get"
    ),
    nina_version = list(
      api = "nina",
      path = "/dynamic/version/dataVersion.json",
      method = "get"
    ),
    nina_mapdata_katwarn = list(
      api = "nina",
      path = "/katwarn/mapData.json",
      method = "get"
    ),
    nina_mapdata_biwapp = list(
      api = "nina",
      path = "/biwapp/mapData.json",
      method = "get"
    ),
    nina_mapdata_mowas = list(
      api = "nina",
      path = "/mowas/mapData.json",
      method = "get"
    ),
    nina_mapdata_dwd = list(
      api = "nina",
      path = "/dwd/mapData.json",
      method = "get"
    ),
    nina_mapdata_lhp = list(
      api = "nina",
      path = "/lhp/mapData.json",
      method = "get"
    ),
    nina_mapdata_police = list(
      api = "nina",
      path = "/police/mapData.json",
      method = "get"
    ),
    nina_archive_mowas_mapping = list(
      api = "nina",
      path = "/archive.mowas/{identifier}-mapping.json",
      method = "get"
    ),
    nina_archive_mowas = list(
      api = "nina",
      path = "/archive.mowas/{identifier}.json",
      method = "get"
    ),
    nina_mowas_rss = list(
      api = "nina",
      path = "/mowas/rss/{ARS}.rss",
      method = "get"
    ),
    nina_representatives_germany = list(
      api = "nina",
      path = "/representativesInGermany",
      method = "get"
    ),
    nina_representatives_country = list(
      api = "nina",
      path = "/representativesInCountry",
      method = "get"
    ),
    nina_state_names = list(
      api = "nina",
      path = "/stateNames",
      method = "get"
    ),
    nina_healthcare = list(
      api = "nina",
      path = "/healthcare",
      method = "get"
    ),
    abfallnavi_orte = list(
      api = "abfallnavi",
      path = "/orte",
      method = "get"
    ),
    abfallnavi_ort = list(
      api = "abfallnavi",
      path = "/orte/{ortId}",
      method = "get"
    ),
    abfallnavi_strassen = list(
      api = "abfallnavi",
      path = "/orte/{ortId}/strassen",
      method = "get"
    ),
    abfallnavi_hausnummern = list(
      api = "abfallnavi",
      path = "/strassen/{strassenId}",
      method = "get"
    ),
    abfallnavi_fraktionen = list(
      api = "abfallnavi",
      path = "/fraktionen",
      method = "get"
    ),
    abfallnavi_fraktionen_hausnummern = list(
      api = "abfallnavi",
      path = "/hausnummern/{hausnummernId}/fraktionen",
      method = "get"
    ),
    abfallnavi_fraktionen_strassen = list(
      api = "abfallnavi",
      path = "/strassen/{strassenId}/fraktionen",
      method = "get"
    ),
    abfallnavi_termine_strassen = list(
      api = "abfallnavi",
      path = "/strassen/{strassenId}/termine",
      method = "get"
    ),
    abfallnavi_termine_hausnummern = list(
      api = "abfallnavi",
      path = "/hausnummern/{hausnummernId}/termine",
      method = "get"
    ),
    abfallnavi_kalender_download = list(
      api = "abfallnavi",
      path = "/kalender-{region}/downloadfile.jsp",
      method = "get"
    ),
    ausbildungssuche_search = list(
      api = "ausbildungssuche",
      path = "/pc/v1/ausbildungsangebot",
      method = "get"
    ),
    ausbildungssuche_details = list(
      api = "ausbildungssuche",
      path = "/pc/v1/ausbildungsangebot/{id}",
      method = "get"
    ),
    berufssprachkurssuche_search = list(
      api = "berufssprachkurssuche",
      path = "/pc/v1/bildungsangebot",
      method = "get"
    ),
    coachingangebote_search = list(
      api = "coachingangebote",
      path = "/pc/v1/aktivierungsangebote",
      method = "get"
    )
  )
}
