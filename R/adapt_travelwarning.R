#' List travel warnings
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' The travelwarning API provides travel and safety information from the
#' Auswaertiges Amt. This endpoint returns a list of all travel warnings with
#' metadata. API documentation: \url{https://travelwarning.api.bund.dev}.
#'
#' @seealso
#' [travelwarning_warning()] for full details of a single warning.
#'
#' @examples
#' \dontrun{
#' travelwarning_warnings()
#' }
#'
#' @return A tibble with one row per warning entry.
#' \describe{
#'   \item{content_id}{Character. Entry/content identifier.}
#'   \item{parent_content_id}{Character. Parent identifier for nested records.}
#'   \item{response_country}{Character. Country code from response metadata.}
#'   \item{response_last_modified}{Numeric. Feed-level modification timestamp
#'     in milliseconds.}
#'   \item{response_last_modified_time}{POSIXct. Parsed feed-level timestamp
#'     (Europe/Berlin).}
#'   \item{last_modified_time}{POSIXct. Entry-level modification timestamp
#'     (Europe/Berlin).}
#'   \item{effective_time}{POSIXct. Entry effective timestamp (Europe/Berlin).}
#'   \item{last_modified}{Numeric. Raw entry modification timestamp in ms.}
#'   \item{effective}{Numeric. Raw entry effective timestamp in ms.}
#'   \item{title}{Character. Country travel warning title.}
#'   \item{country_code}{Character. Two-letter country code.}
#'   \item{country_name}{Character. Country name (German).}
#'   \item{warning}{Logical. Full travel warning issued.}
#'   \item{partial_warning}{Logical. Partial travel warning issued.}
#'   \item{situation_warning}{Logical. Situation-based travel warning.}
#'   \item{situation_part_warning}{Logical. Situation-based partial warning.}
#' }
#' @family Travelwarning
#' @export
travelwarning_warnings <- function(safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "travelwarning",
    "getTravelwarning",
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  travelwarning_tidy_entries(response)
}

#' Get a travel warning by content id
#'
#' @param content_id Travel warning content id.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns the full travel warning content, including HTML blocks.
#' API documentation: \url{https://travelwarning.api.bund.dev}.
#'
#' @seealso
#' [travelwarning_warnings()] to list available ids.
#'
#' @examples
#' \dontrun{
#' warnings <- travelwarning_warnings()
#' travelwarning_warning(warnings$content_id[[1]])
#' }
#'
#' @return A tibble with one row per warning content block. Same metadata
#' columns as [travelwarning_warnings()], plus the full warning detail fields:
#' \describe{
#'   \item{content_id}{Character. Entry/content identifier.}
#'   \item{parent_content_id}{Character. Parent identifier for nested records.}
#'   \item{response_country}{Character. Country code from response metadata.}
#'   \item{response_last_modified}{Numeric. Feed-level modification timestamp
#'     in milliseconds.}
#'   \item{response_last_modified_time}{POSIXct. Parsed feed-level timestamp
#'     (Europe/Berlin).}
#'   \item{last_modified_time}{POSIXct. Entry-level modification timestamp
#'     (Europe/Berlin).}
#'   \item{effective_time}{POSIXct. Entry effective timestamp (Europe/Berlin).}
#'   \item{last_modified}{Numeric. Raw entry modification timestamp in ms.}
#'   \item{effective}{Numeric. Raw entry effective timestamp in ms.}
#'   \item{title}{Character. Country travel warning title.}
#'   \item{country_code}{Character. Two-letter country code.}
#'   \item{iso3_country_code}{Character. Three-letter ISO country code.}
#'   \item{country_name}{Character. Country name (German).}
#'   \item{warning}{Logical. Full travel warning issued.}
#'   \item{partial_warning}{Logical. Partial travel warning issued.}
#'   \item{situation_warning}{Logical. Situation-based travel warning.}
#'   \item{situation_part_warning}{Logical. Situation-based partial warning.}
#'   \item{content}{Character. HTML content of the warning.}
#' }
#' @family Travelwarning
#' @export
travelwarning_warning <- function(content_id, safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "travelwarning",
    "getSingleTravelwarning",
    params = list(contentId = content_id),
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  travelwarning_tidy_entries(response)
}

#' List foreign representatives in Germany
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns a list of foreign representatives in Germany. API documentation: \url{https://travelwarning.api.bund.dev}.
#'
#' @examples
#' \dontrun{
#' travelwarning_representatives_germany()
#' }
#'
#' @return A tibble with one row per foreign representative in Germany:
#' \describe{
#'   \item{content_id}{Character. Entry/content identifier.}
#'   \item{parent_content_id}{Character. Parent identifier for nested records.}
#'   \item{response_country}{Character. Country code from response metadata.}
#'   \item{response_last_modified}{Numeric. Feed-level modification timestamp.}
#'   \item{response_last_modified_time}{POSIXct. Parsed feed-level timestamp.}
#'   \item{last_modified_time}{POSIXct. Entry-level modification timestamp.}
#'   \item{effective_time}{POSIXct. Entry effective timestamp.}
#'   \item{last_modified}{Numeric. Raw entry modification timestamp in ms.}
#'   \item{title}{Character. Representation title.}
#'   \item{leader}{Character. Head of mission.}
#'   \item{locales}{Character. Languages spoken.}
#'   \item{country}{Character. Country.}
#'   \item{zip}{Character. Postal code.}
#'   \item{city}{Character. City.}
#'   \item{region}{Character. Region.}
#'   \item{street}{Character. Street.}
#'   \item{number}{Character. House number.}
#'   \item{departments}{Character. Department details.}
#'   \item{fax}{Character. Fax number.}
#'   \item{telefone}{Character. Phone number.}
#'   \item{mail}{Character. Email address.}
#'   \item{misc}{Character. Miscellaneous notes.}
#'   \item{url}{Character. External link.}
#'   \item{postal}{Character. Postal address.}
#'   \item{type}{Character. Address type (e.g. Botschaft).}
#'   \item{remark}{Character. Remark.}
#'   \item{open}{Character. Opening hours.}
#' }
#' @family Travelwarning
#' @export
travelwarning_representatives_germany <- function(safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "travelwarning",
    "getRepresentativesGermany",
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  travelwarning_tidy_entries(response)
}

#' List German representatives in foreign countries
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns a list of German representatives in foreign countries. API documentation: \url{https://travelwarning.api.bund.dev}.
#'
#' @examples
#' \dontrun{
#' travelwarning_representatives_country()
#' }
#'
#' @return A tibble with one row per German representative abroad:
#' \describe{
#'   \item{content_id}{Character. Entry/content identifier.}
#'   \item{parent_content_id}{Character. Parent identifier for nested records.}
#'   \item{response_country}{Character. Country code from response metadata.}
#'   \item{response_last_modified}{Numeric. Feed-level modification timestamp.}
#'   \item{response_last_modified_time}{POSIXct. Parsed feed-level timestamp.}
#'   \item{last_modified_time}{POSIXct. Entry-level modification timestamp.}
#'   \item{effective_time}{POSIXct. Entry effective timestamp.}
#'   \item{last_modified}{Numeric. Raw entry modification timestamp in ms.}
#'   \item{title}{Character. Representation title.}
#'   \item{leader}{Character. Head of mission.}
#'   \item{locales}{Character. Languages spoken.}
#'   \item{country}{Character. Country.}
#'   \item{zip}{Character. Postal code.}
#'   \item{city}{Character. City.}
#'   \item{region}{Character. Region.}
#'   \item{street}{Character. Street.}
#'   \item{number}{Character. House number.}
#'   \item{departments}{Character. Department details.}
#'   \item{fax}{Character. Fax number.}
#'   \item{telefone}{Character. Phone number.}
#'   \item{mail}{Character. Email address.}
#'   \item{misc}{Character. Miscellaneous notes.}
#'   \item{url}{Character. External link.}
#'   \item{postal}{Character. Postal address.}
#'   \item{type}{Character. Address type (e.g. Botschaft).}
#'   \item{remark}{Character. Remark.}
#'   \item{open}{Character. Opening hours.}
#' }
#' @family Travelwarning
#' @export
travelwarning_representatives_country <- function(safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "travelwarning",
    "getRepresentativesCountry",
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  travelwarning_tidy_entries(response)
}

#' List state names documents
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns documents with state name information. API documentation: \url{https://travelwarning.api.bund.dev}.
#'
#' @examples
#' \dontrun{
#' travelwarning_state_names()
#' }
#'
#' @return A tibble with one row per state-name document:
#' \describe{
#'   \item{content_id}{Character. Entry/content identifier.}
#'   \item{parent_content_id}{Character. Parent identifier for nested records.}
#'   \item{response_country}{Character. Country code from response metadata.}
#'   \item{response_last_modified}{Numeric. Feed-level modification timestamp.}
#'   \item{response_last_modified_time}{POSIXct. Parsed feed-level timestamp.}
#'   \item{last_modified_time}{POSIXct. Entry-level modification timestamp.}
#'   \item{effective_time}{POSIXct. Entry effective timestamp.}
#'   \item{last_modified}{Numeric. Raw entry modification timestamp in ms.}
#'   \item{name}{Character. Document name.}
#'   \item{url}{Character. Download URL.}
#' }
#' @family Travelwarning
#' @export
travelwarning_state_names <- function(safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "travelwarning",
    "getStateNames",
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  travelwarning_tidy_entries(response)
}

#' List healthcare documents
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns healthcare documents provided by the Auswaertiges Amt.
#' API documentation: \url{https://travelwarning.api.bund.dev}.
#'
#' @examples
#' \dontrun{
#' travelwarning_healthcare()
#' }
#'
#' @return A tibble with one row per healthcare document:
#' \describe{
#'   \item{content_id}{Character. Entry/content identifier.}
#'   \item{parent_content_id}{Character. Parent identifier for nested records.}
#'   \item{response_country}{Character. Country code from response metadata.}
#'   \item{response_last_modified}{Numeric. Feed-level modification timestamp.}
#'   \item{response_last_modified_time}{POSIXct. Parsed feed-level timestamp.}
#'   \item{last_modified_time}{POSIXct. Entry-level modification timestamp.}
#'   \item{effective_time}{POSIXct. Entry effective timestamp.}
#'   \item{last_modified}{Numeric. Raw entry modification timestamp in ms.}
#'   \item{name}{Character. Document name.}
#'   \item{url}{Character. Download URL.}
#' }
#' @family Travelwarning
#' @export
travelwarning_healthcare <- function(safe = TRUE, refresh = FALSE) {
  response <- bunddev_call(
    "travelwarning",
    "getHealthcare",
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  travelwarning_tidy_entries(response)
}

travelwarning_tidy_entries <- function(response) {
  payload <- response$response %||% response
  if (is.null(payload) || length(payload) == 0) {
    return(tibble::tibble())
  }

  response_country <- payload$country %||% NA_character_
  response_last_modified <- payload$lastModified %||% NA_integer_

  entries <- payload[setdiff(names(payload), c("lastModified", "contentList", "country"))]
  if (length(entries) == 0) {
    return(tibble::tibble())
  }

  snake_case <- function(name) {
    name <- stringr::str_replace_all(name, "([a-z0-9])([A-Z])", "\\1_\\2")
    tolower(name)
  }

  to_time <- function(value) {
    if (is.null(value) || length(value) == 0 || is.na(value[[1]])) {
      return(as.POSIXct(NA_real_, origin = "1970-01-01", tz = "Europe/Berlin"))
    }
    as.POSIXct(as.numeric(value[[1]]), origin = "1970-01-01", tz = "Europe/Berlin")
  }

  is_id_key <- function(name) {
    stringr::str_detect(name, "^[0-9]+$")
  }

  build_row <- function(entry, content_id, parent_content_id, country) {
    if (!is.list(entry)) {
      entry <- list(value = entry)
    }

    data <- tibble::as_tibble(entry)
    names(data) <- snake_case(names(data))
    data$content_id <- content_id
    data$parent_content_id <- parent_content_id
    data$response_country <- country
    data$response_last_modified <- response_last_modified
    data$last_modified_time <- to_time(entry$lastModified %||% NA_integer_)
    data$effective_time <- to_time(entry$effective %||% NA_integer_)
    if (!is.na(response_last_modified)) {
      data$response_last_modified_time <- to_time(response_last_modified)
    }
    data
  }

  purrr::imap_dfr(entries, function(entry, content_id) {
    if (!is.list(entry)) {
      return(build_row(entry, content_id, NA_character_, response_country))
    }

    entry_country <- entry$country %||% response_country
    nested_entries <- entry[is_id_key(names(entry))]
    if (length(nested_entries) > 0 && !is.null(entry$contentList)) {
      return(purrr::imap_dfr(nested_entries, function(nested, nested_id) {
        build_row(nested, nested_id, content_id, entry_country)
      }))
    }

    build_row(entry, content_id, NA_character_, entry_country)
  })
}

bunddev_travelwarning_warnings <- function(safe = TRUE, refresh = FALSE) {
  travelwarning_warnings(safe = safe, refresh = refresh)
}

bunddev_travelwarning_warning <- function(content_id, safe = TRUE, refresh = FALSE) {
  travelwarning_warning(content_id = content_id, safe = safe, refresh = refresh)
}

bunddev_travelwarning_representatives_germany <- function(safe = TRUE, refresh = FALSE) {
  travelwarning_representatives_germany(safe = safe, refresh = refresh)
}

bunddev_travelwarning_representatives_country <- function(safe = TRUE, refresh = FALSE) {
  travelwarning_representatives_country(safe = safe, refresh = refresh)
}

bunddev_travelwarning_state_names <- function(safe = TRUE, refresh = FALSE) {
  travelwarning_state_names(safe = safe, refresh = refresh)
}

bunddev_travelwarning_healthcare <- function(safe = TRUE, refresh = FALSE) {
  travelwarning_healthcare(safe = safe, refresh = refresh)
}
