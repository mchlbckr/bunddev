#' List approved plant protection products
#'
#' @param kennr Optional product identification number (9 characters).
#' @param params Named list of query parameters. Frequently used keys:
#'   \describe{
#'     \item{kennr}{Product id (e.g. `"024780-00"`).}
#'     \item{wirkstoffId}{Active ingredient id.}
#'     \item{awg_id}{Application id.}
#'     \item{kultur}{Crop filter code.}
#'     \item{kultur_gruppe}{Crop group filter code.}
#'     \item{kode}{Code filter for catalog lookups.}
#'     \item{kodeliste}{Code list name.}
#'     \item{sprache}{Language code.}
#'   }
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' The Pflanzenschutzmittelzulassung API provides access to Germany's plant
#' protection product database from the Bundesamt fuer Verbraucherschutz und
#' Lebensmittelsicherheit (BVL). This function returns approved pesticides.
#' API documentation: \url{https://github.com/bundesAPI/pflanzenschutzmittelzulassung-api}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' [psm_wirkstoffe()] to list active ingredients,
#' [psm_stand()] for data version.
#'
#' @examples
#' \dontrun{
#' psm_mittel()
#' psm_mittel(kennr = "024780-00")
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per plant protection product
#'   and columns:
#'   \describe{
#'     \item{FORMULIERUNG_ART}{Character. Formulation type code.}
#'     \item{KENNR}{Character. Product identification number.}
#'     \item{MITTELNAME}{Character. Product trade name.}
#'     \item{ZUL_ENDE}{Character. Approval end date.}
#'     \item{ZUL_ERSTMALIG_AM}{Character. Initial approval date.}
#'   }
#' @family Pflanzenschutzmittelzulassung
#' @export
psm_mittel <- function(kennr = NULL,
                       params = list(),
                       safe = TRUE,
                       refresh = FALSE) {
  if (!is.null(kennr)) {
    params$kennr <- kennr
  }

  response <- psm_request(
    "/mittel/",
    params = params,
    safe = safe,
    refresh = refresh
  )

  psm_tidy_items(response)
}

#' List active ingredients
#'
#' @param wirkstoffId Optional active ingredient ID.
#' @inheritParams psm_mittel
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns active ingredients (Wirkstoffe) from the plant protection product
#' database.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' [psm_mittel()] to list products.
#'
#' @examples
#' \dontrun{
#' psm_wirkstoffe()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per active ingredient and
#'   columns:
#'   \describe{
#'     \item{GENEHMIGT}{Character. Approval flag.}
#'     \item{KATEGORIE}{Character. Ingredient category.}
#'     \item{WIRKNR}{Character. Active ingredient number.}
#'     \item{WIRKSTOFFNAME}{Character. Active ingredient name (German).}
#'     \item{WIRKSTOFFNAME_EN}{Character. Active ingredient name (English).}
#'   }
#' @family Pflanzenschutzmittelzulassung
#' @export
psm_wirkstoffe <- function(wirkstoffId = NULL,
                           params = list(),
                           safe = TRUE,
                           refresh = FALSE) {
  if (!is.null(wirkstoffId)) {
    params$wirkstoffId <- wirkstoffId
  }

  response <- psm_request(
    "/wirkstoff/",
    params = params,
    safe = safe,
    refresh = refresh
  )

  psm_tidy_items(response)
}

#' List approved applications
#'
#' @param kennr Optional product identification number.
#' @param awg_id Optional application identifier (16 characters).
#' @inheritParams psm_mittel
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns approved applications (Anwendungsgebiete) which define the
#' combinations of products, crops, and pests for which use is permitted.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' [psm_mittel()] to list products.
#'
#' @examples
#' \dontrun{
#' psm_anwendungen(kennr = "024780-00")
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per approved application and
#'   columns:
#'   \describe{
#'     \item{ANTRAGNR}{Character. Application request number.}
#'     \item{ANWENDUNGEN_ANZ_JE_BEFALL}{Numeric. Applications per infestation.}
#'     \item{ANWENDUNGEN_MAX_JE_KULTUR}{Numeric. Max applications per crop.}
#'     \item{ANWENDUNGEN_MAX_JE_VEGETATION}{Numeric. Max applications per vegetation period.}
#'     \item{ANWENDUNGSBEREICH}{Character. Area of use code.}
#'     \item{ANWENDUNGSTECHNIK}{Character. Application technique.}
#'     \item{AWGNR}{Character. Application group number.}
#'     \item{AWG_ID}{Character. Application identifier (16 chars).}
#'     \item{AW_ABSTAND_BIS}{Numeric. Application interval upper bound.}
#'     \item{AW_ABSTAND_EINHEIT}{Character. Interval unit.}
#'     \item{AW_ABSTAND_VON}{Numeric. Application interval lower bound.}
#'     \item{EINSATZGEBIET}{Character. Field of use code.}
#'     \item{GENEHMIGUNG}{Character. Approval flag.}
#'     \item{HUK}{Character. Home-and-garden flag.}
#'     \item{KENNR}{Character. Product identification number.}
#'     \item{KULTUR_ERL}{Character. Crop clarification text.}
#'     \item{SCHADORG_ERL}{Character. Pest clarification text.}
#'     \item{STADIUM_KULTUR_BEM}{Character. Crop growth-stage note.}
#'     \item{STADIUM_KULTUR_BIS}{Character. Crop growth-stage upper bound.}
#'     \item{STADIUM_KULTUR_KODELISTE}{Numeric. Crop growth-stage code list.}
#'     \item{STADIUM_KULTUR_VON}{Character. Crop growth-stage lower bound.}
#'     \item{STADIUM_SCHADORG_BEM}{Character. Pest growth-stage note.}
#'     \item{STADIUM_SCHADORG_BIS}{Character. Pest growth-stage upper bound.}
#'     \item{STADIUM_SCHADORG_KODELISTE}{Numeric. Pest growth-stage code list.}
#'     \item{STADIUM_SCHADORG_VON}{Character. Pest growth-stage lower bound.}
#'     \item{WIRKUNGSBEREICH}{Character. Efficacy area code.}
#'   }
#' @family Pflanzenschutzmittelzulassung
#' @export
psm_anwendungen <- function(kennr = NULL,
                            awg_id = NULL,
                            params = list(),
                            safe = TRUE,
                            refresh = FALSE) {
  if (!is.null(kennr)) {
    params$kennr <- kennr
  }
  if (!is.null(awg_id)) {
    params$awg_id <- awg_id
  }

  response <- psm_request(
    "/awg/",
    params = params,
    safe = safe,
    refresh = refresh
  )

  psm_tidy_items(response)
}

#' Get data version
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns the release date/version of the plant protection product database.
#'
#' @examples
#' \dontrun{
#' psm_stand()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row and columns:
#'   \describe{
#'     \item{DATUM}{Character. Release date of the current data set.}
#'   }
#' @family Pflanzenschutzmittelzulassung
#' @export
psm_stand <- function(safe = TRUE, refresh = FALSE) {
  response <- psm_request(
    "/stand/",
    params = list(),
    safe = safe,
    refresh = refresh
  )

  psm_tidy_items(response)
}

#' List crop groups
#'
#' @inheritParams psm_mittel
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns hierarchical crop group classifications.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' psm_kultur_gruppen()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per crop-to-group mapping
#'   and columns:
#'   \describe{
#'     \item{KULTUR}{Character. Crop code (child).}
#'     \item{KULTUR_GRUPPE}{Character. Crop group code (parent).}
#'   }
#' @family Pflanzenschutzmittelzulassung
#' @export
psm_kultur_gruppen <- function(params = list(),
                               safe = TRUE,
                               refresh = FALSE) {
  response <- psm_request(
    "/kultur_gruppe/",
    params = params,
    safe = safe,
    refresh = refresh
  )

  psm_tidy_items(response)
}

#' List pest groups
#'
#' @inheritParams psm_mittel
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns hierarchical pest/pathogen group classifications.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' psm_schadorg_gruppen()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per pest-to-group mapping
#'   and columns:
#'   \describe{
#'     \item{SCHADORG}{Character. Pest organism code (child).}
#'     \item{SCHADORG_GRUPPE}{Character. Pest group code (parent).}
#'   }
#' @family Pflanzenschutzmittelzulassung
#' @export
psm_schadorg_gruppen <- function(params = list(),
                                 safe = TRUE,
                                 refresh = FALSE) {
  response <- psm_request(
    "/schadorg_gruppe/",
    params = params,
    safe = safe,
    refresh = refresh
  )

  psm_tidy_items(response)
}

psm_request <- function(path, params = list(), safe = TRUE, refresh = FALSE, parse = "json") {
  bunddev_call(
    "pflanzenschutzmittelzulassung",
    path = path,
    method = "GET",
    params = params,
    parse = parse,
    safe = safe,
    refresh = refresh
  )
}

psm_tidy_items <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  items <- response$items
  if (is.null(items) || length(items) == 0) {
    if (is.data.frame(response)) {
      return(tibble::as_tibble(response))
    }
    return(tibble::tibble(response = list(response)))
  }

  if (is.data.frame(items)) {
    data <- tibble::as_tibble(items)
    if ("m_row$$" %in% names(data)) {
      data$`m_row$$` <- NULL
    }
    return(data)
  }

  rows <- purrr::map(items, function(item) {
    item$`m_row$$` <- NULL
    tibble::as_tibble(purrr::map(item, ~ if (is.null(.x)) NA else .x))
  })

  dplyr::bind_rows(rows)
}

bunddev_psm_mittel <- function(kennr = NULL,
                               params = list(),
                               safe = TRUE,
                               refresh = FALSE) {
  psm_mittel(
    kennr = kennr,
    params = params,
    safe = safe,
    refresh = refresh
  )
}

bunddev_psm_wirkstoffe <- function(wirkstoffId = NULL,
                                   params = list(),
                                   safe = TRUE,
                                   refresh = FALSE) {
  psm_wirkstoffe(
    wirkstoffId = wirkstoffId,
    params = params,
    safe = safe,
    refresh = refresh
  )
}

bunddev_psm_anwendungen <- function(kennr = NULL,
                                    awg_id = NULL,
                                    params = list(),
                                    safe = TRUE,
                                    refresh = FALSE) {
  psm_anwendungen(
    kennr = kennr,
    awg_id = awg_id,
    params = params,
    safe = safe,
    refresh = refresh
  )
}

bunddev_psm_stand <- function(safe = TRUE, refresh = FALSE) {
  psm_stand(safe = safe, refresh = refresh)
}

bunddev_psm_kultur_gruppen <- function(params = list(),
                                       safe = TRUE,
                                       refresh = FALSE) {
  psm_kultur_gruppen(params = params, safe = safe, refresh = refresh)
}

bunddev_psm_schadorg_gruppen <- function(params = list(),
                                         safe = TRUE,
                                         refresh = FALSE) {
  psm_schadorg_gruppen(params = params, safe = safe, refresh = refresh)
}
