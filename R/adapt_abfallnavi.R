#' List available places
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' The Abfallnavi API provides waste collection data for supported regions.
#' Start by listing places (Orte) to obtain an `ortId`. API documentation: \url{https://bundesapi.github.io/abfallnavi-api/}.
#'
#' @seealso
#' [abfallnavi_strassen()] for streets in a place.
#'
#' @examples
#' \dontrun{
#' abfallnavi_orte()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per place and columns:
#'   \describe{
#'     \item{id}{Integer. Place identifier.}
#'     \item{name}{Character. Place name.}
#'   }
#' @family Abfallnavi
#' @export
abfallnavi_orte <- function(safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "abfallnavi",
    "orte",
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  abfallnavi_tidy_list(response)
}

#' Get a place by id
#'
#' @param ort_id Place id.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @return A one-row [tibble][tibble::tibble] with columns:
#'   \describe{
#'     \item{id}{Integer. Place identifier.}
#'     \item{name}{Character. Place name.}
#'   }
#' @family Abfallnavi
#' @export
abfallnavi_ort <- function(ort_id, safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "abfallnavi",
    "ort",
    params = list(ortId = ort_id),
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  abfallnavi_tidy_single(response)
}

#' List streets for a place
#'
#' @param ort_id Place id.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @return A [tibble][tibble::tibble] with one row per street and columns:
#'   \describe{
#'     \item{id}{Integer. Street identifier.}
#'     \item{name}{Character. Street name.}
#'     \item{staticId}{Character. Static identifier (base64-encoded).}
#'     \item{hausNrList}{List. House numbers for this street.}
#'     \item{plz}{Character. Postal code (may be `NA`).}
#'     \item{ortsteilName}{Character. District name.}
#'     \item{ort}{List. Nested place object.}
#'   }
#' @family Abfallnavi
#' @export
abfallnavi_strassen <- function(ort_id, safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "abfallnavi",
    "strassenProOrt",
    params = list(ortId = ort_id),
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  abfallnavi_tidy_list(response)
}

#' List house numbers for a street
#'
#' @param strassen_id Street id.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @return A [tibble][tibble::tibble] with one row per house number and columns:
#'   \describe{
#'     \item{id}{Integer. House number identifier.}
#'     \item{nr}{Character. House number label.}
#'     \item{plz}{Character. Postal code.}
#'     \item{staticId}{Character. Static identifier (base64-encoded).}
#'   }
#' @family Abfallnavi
#' @export
abfallnavi_hausnummern <- function(strassen_id, safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "abfallnavi",
    "hausnummernProStrasse",
    params = list(strassenId = strassen_id),
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  abfallnavi_tidy_list(response)
}

#' List waste fractions
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @return A [tibble][tibble::tibble] with one row per waste fraction and columns:
#'   \describe{
#'     \item{id}{Integer. Fraction identifier.}
#'     \item{name}{Character. Fraction name (e.g. "Restabfall").}
#'     \item{iconNr}{Integer. Icon number for display.}
#'     \item{farbeRgb}{Character. RGB colour hex code.}
#'   }
#' @family Abfallnavi
#' @export
abfallnavi_fraktionen <- function(safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "abfallnavi",
    "muellarten",
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  abfallnavi_tidy_list(response)
}

#' List waste fractions for a house number
#'
#' @param hausnummern_id House number id.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @return A [tibble][tibble::tibble] with one row per waste fraction and columns:
#'   \describe{
#'     \item{id}{Integer. Fraction identifier.}
#'     \item{name}{Character. Fraction name (e.g. "Restabfall").}
#'     \item{iconNr}{Integer. Icon number for display.}
#'     \item{farbeRgb}{Character. RGB colour hex code.}
#'   }
#' @family Abfallnavi
#' @export
abfallnavi_fraktionen_hausnummern <- function(hausnummern_id, safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "abfallnavi",
    "muellartenProHausnummer",
    params = list(hausnummernId = hausnummern_id),
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  abfallnavi_tidy_list(response)
}

#' List waste fractions for a street
#'
#' @param strassen_id Street id.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @return A [tibble][tibble::tibble] with one row per waste fraction and columns:
#'   \describe{
#'     \item{id}{Integer. Fraction identifier.}
#'     \item{name}{Character. Fraction name (e.g. "Restabfall").}
#'     \item{iconNr}{Integer. Icon number for display.}
#'     \item{farbeRgb}{Character. RGB colour hex code.}
#'   }
#' @family Abfallnavi
#' @export
abfallnavi_fraktionen_strassen <- function(strassen_id, safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "abfallnavi",
    "muellartenProStrasse",
    params = list(strassenId = strassen_id),
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  abfallnavi_tidy_list(response)
}

#' List collection dates for a street
#'
#' @param strassen_id Street id.
#' @param fraktion Fraction ids.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @return A [tibble][tibble::tibble] with one row per collection date and columns:
#'   \describe{
#'     \item{id}{Integer. Collection event identifier.}
#'     \item{bezirk}{List. District information for this collection.}
#'     \item{datum}{Character. Collection date (YYYY-MM-DD).}
#'     \item{date_time}{POSIXct. Parsed collection date (Europe/Berlin).}
#'   }
#' @family Abfallnavi
#' @export
abfallnavi_termine_strassen <- function(strassen_id, fraktion, safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "abfallnavi",
    "termineProStrasse",
    params = list(strassenId = strassen_id, fraktion = fraktion),
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  abfallnavi_tidy_termine(response)
}

#' List collection dates for a house number
#'
#' @param hausnummern_id House number id.
#' @param fraktion Fraction ids.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @return A [tibble][tibble::tibble] with one row per collection date and columns:
#'   \describe{
#'     \item{id}{Integer. Collection event identifier.}
#'     \item{bezirk}{List. District information for this collection.}
#'     \item{datum}{Character. Collection date (YYYY-MM-DD).}
#'     \item{date_time}{POSIXct. Parsed collection date (Europe/Berlin).}
#'   }
#' @family Abfallnavi
#' @export
abfallnavi_termine_hausnummern <- function(hausnummern_id, fraktion, safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "abfallnavi",
    "termineProHaussnummer",
    params = list(hausnummernId = hausnummern_id, fraktion = fraktion),
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  abfallnavi_tidy_termine(response)
}

#' Download calendar file
#'
#' @param region Region code.
#' @param format File format.
#' @param jahr Year.
#' @param ort Place name.
#' @param strasse Street id.
#' @param hnr House number id.
#' @param fraktion Fraction ids.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Downloads a calendar file for the requested address and fraction.
#'
#' @return A one-row [tibble][tibble::tibble] with columns:
#'   \describe{
#'     \item{region}{Character. Region code passed to the request.}
#'     \item{format}{Character. File format ("pdf" or "ics").}
#'     \item{jahr}{Integer. Year passed to the request.}
#'     \item{bytes}{List. Raw file bytes (raw vector).}
#'   }
#' @family Abfallnavi
#' @export
abfallnavi_kalender_download <- function(region,
                                         format,
                                         jahr,
                                         ort,
                                         strasse,
                                         hnr,
                                         fraktion,
                                         safe = TRUE,
                                         refresh = FALSE) {
  response <- bunddev_call(
    "abfallnavi",
    "downloadAsFile",
    params = list(
      region = region,
      format = format,
      jahr = jahr,
      ort = ort,
      strasse = strasse,
      hnr = hnr,
      fraktion = fraktion
    ),
    parse = "raw",
    safe = safe,
    refresh = refresh
  )

  tibble::tibble(region = region, format = format, jahr = jahr, bytes = list(response))
}

abfallnavi_tidy_list <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  sanitize_entry <- function(entry) {
    values <- purrr::map(entry, function(value) {
      if (is.null(value)) {
        return(NA)
      }
      if (is.list(value) || length(value) != 1) {
        return(list(value))
      }
      value
    })
    tibble::as_tibble(values)
  }

  rows <- purrr::map(response, sanitize_entry)
  dplyr::bind_rows(rows)
}

abfallnavi_tidy_single <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }
  abfallnavi_tidy_list(list(response))
}

abfallnavi_tidy_termine <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  data <- dplyr::bind_rows(response)
  if ("datum" %in% names(data)) {
    data$date_time <- as.POSIXct(data$datum, tz = "Europe/Berlin")
  }
  data
}
