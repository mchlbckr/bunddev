#' List DIP Vorgang entries
#'
#' @param params Named list of query parameters. Common keys:
#'   \describe{
#'     \item{format}{Response format (`"json"` recommended; default set by adapter).}
#'     \item{apikey}{Optional API key as query parameter (prefer auth header).}
#'     \item{fuzzy}{Free-text search string (character).}
#'     \item{sort}{Sort field/order definition (character).}
#'     \item{cursor}{Cursor for pagination (character).}
#'     \item{limit}{Page size/maximum number of documents (integer).}
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
#' @details
#' Returns metadata for DIP Vorgang entries. Requires an API key. Obtain a key
#' from https://dip.bundestag.de/über-dip/hilfe/api.
#'
#' Configure authentication via [bunddev_auth_set()] or set the
#' `DIP_BUNDESTAG_API_KEY` environment variable directly.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' [bunddev_auth_set()] to configure authentication.
#'
#' @examples
#' \dontrun{
#' # Recommended: use bunddev_auth_set
#' Sys.setenv(DIP_BUNDESTAG_API_KEY = "<api-key>")
#' bunddev_auth_set(
#'   "dip_bundestag",
#'   type = "api_key",
#'   env_var = "DIP_BUNDESTAG_API_KEY",
#'   scheme = "ApiKey"
#' )
#' dip_bundestag_vorgang_list()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per Vorgang and columns:
#'   \describe{
#'     \item{id}{Character. Unique Vorgang identifier.}
#'     \item{typ}{Character. Entity type, always `"Vorgang"`.}
#'     \item{beratungsstand}{Character. Consultation status.}
#'     \item{vorgangstyp}{Character. Vorgang type.}
#'     \item{wahlperiode}{Integer. Legislative period.}
#'     \item{datum}{Character. Date of last associated document.}
#'     \item{aktualisiert}{Character. Last update timestamp.}
#'     \item{titel}{Character. Title text.}
#'     \item{abstract}{Character. Summary text.}
#'     \item{gesta}{Character. GESTA reference number.}
#'     \item{kom}{Character. EU COM reference number.}
#'     \item{ratsdok}{Character. EU Council document number.}
#'     \item{archiv}{Character. Archive reference.}
#'     \item{mitteilung}{Character. Supplementary note.}
#'     \item{sek}{Character. EU SEC reference number.}
#'     \item{initiative}{List. Initiating factions or bodies.}
#'     \item{sachgebiet}{List. Subject areas.}
#'     \item{deskriptor}{List. Thesaurus descriptor entries.}
#'     \item{zustimmungsbeduerftigkeit}{List. Consent requirements.}
#'     \item{verkuendung}{List. Promulgation details.}
#'     \item{inkrafttreten}{List. Entry-into-force details.}
#'     \item{vorgang_verlinkung}{List. Linked Vorgaenge.}
#'   }
#'
#' Wrapped in a one-row tibble with `num_found` (integer), `cursor`
#' (character), and `documents` (list-column) when not yet unpacked.
#' @family DIP Bundestag
#' @export
dip_bundestag_vorgang_list <- function(params = list(),
                                       safe = TRUE,
                                       refresh = FALSE,
                                       flatten = FALSE,
                                       flatten_mode = "json") {
  response <- dip_bundestag_request("/vorgang", params, safe, refresh)
  dip_bundestag_tidy_list(response, flatten, flatten_mode)
}

#' Get a DIP Vorgang
#'
#' @param vorgang_id Vorgang id.
#' @inheritParams dip_bundestag_vorgang_list
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns metadata for a single Vorgang.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' dip_bundestag_vorgang(84343)
#' }
#'
#' @return A one-row tibble for the selected Vorgang:
#' \describe{
#'   \item{id}{Vorgang identifier (character).}
#'   \item{typ}{Entity type, always `"Vorgang"` (character).}
#'   \item{beratungsstand}{Consultation status, e.g. `"Abgeschlossen"` (character).}
#'   \item{vorgangstyp}{Vorgang type, e.g. `"Geschäftsordnung"` (character).}
#'   \item{wahlperiode}{Legislative period (integer).}
#'   \item{initiative}{Initiating factions/bodies (list-column).}
#'   \item{datum}{Date of most recent associated document (character, ISO date).}
#'   \item{aktualisiert}{Last update timestamp (character, ISO datetime).}
#'   \item{titel}{Title (character).}
#'   \item{abstract}{Summary text (character or `NA`).}
#'   \item{sachgebiet}{Subject areas (list-column).}
#'   \item{deskriptor}{Thesaurus descriptors (list-column of named lists).}
#'   \item{gesta}{GESTA reference number (character or `NA`).}
#'   \item{zustimmungsbeduerftigkeit}{Consent requirements (list-column).}
#'   \item{kom}{EU COM reference number (character or `NA`).}
#'   \item{ratsdok}{EU Council document number (character or `NA`).}
#'   \item{verkuendung}{Promulgation details (list-column).}
#'   \item{inkrafttreten}{Entry-into-force details (list-column).}
#'   \item{archiv}{Archive reference (character or `NA`).}
#'   \item{mitteilung}{Supplementary note (character or `NA`).}
#'   \item{vorgang_verlinkung}{Linked Vorgänge (list-column).}
#'   \item{sek}{EU SEC reference number (character or `NA`).}
#' }
#' @family DIP Bundestag
#' @export
dip_bundestag_vorgang <- function(vorgang_id,
                                  params = list(),
                                  safe = TRUE,
                                  refresh = FALSE) {
  response <- dip_bundestag_request(
    "/vorgang/{id}",
    params = c(list(id = vorgang_id), params),
    safe = safe,
    refresh = refresh
  )
  dip_bundestag_tidy_detail(response)
}

#' List DIP Vorgangsposition entries
#'
#' @inheritParams dip_bundestag_vorgang_list
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
#' Returns metadata for Vorgangsposition entries.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' dip_bundestag_vorgangsposition_list()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per Vorgangsposition and columns:
#'   \describe{
#'     \item{id}{Character. Unique Vorgangsposition identifier.}
#'     \item{vorgangsposition}{Character. Step description.}
#'     \item{gang}{Logical. Key step in legislative process.}
#'     \item{fortsetzung}{Logical. Continuation of prior debate.}
#'     \item{nachtrag}{Logical. Addendum entry.}
#'     \item{vorgangstyp}{Character. Parent Vorgang type.}
#'     \item{typ}{Character. Entity type, always `"Vorgangsposition"`.}
#'     \item{titel}{Character. Title of the parent Vorgang.}
#'     \item{dokumentart}{Character. Document type.}
#'     \item{vorgang_id}{Character. Parent Vorgang identifier.}
#'     \item{datum}{Character. Date of associated document.}
#'     \item{aktualisiert}{Character. Last update timestamp.}
#'     \item{aktivitaet_anzahl}{Integer. Total associated activities.}
#'     \item{ratsdok}{Character. EU Council document number.}
#'     \item{kom}{Character. EU COM reference number.}
#'     \item{sek}{Character. EU SEC reference number.}
#'     \item{abstract}{Character. Summary text.}
#'     \item{zuordnung}{List. Assignment to BT/BR/BV/EK.}
#'     \item{fundstelle}{List. Document reference details.}
#'     \item{urheber}{List. Authoring bodies.}
#'     \item{ueberweisung}{List. Committee referrals.}
#'     \item{aktivitaet_anzeige}{List. Up to 4 display activities.}
#'     \item{ressort}{List. Government departments involved.}
#'     \item{beschlussfassung}{List. Voting decisions.}
#'     \item{mitberaten}{List. Co-deliberated Vorgangspositionen.}
#'   }
#'
#' Wrapped in a one-row tibble with `num_found` (integer), `cursor`
#' (character), and `documents` (list-column) when not yet unpacked.
#' @family DIP Bundestag
#' @export
dip_bundestag_vorgangsposition_list <- function(params = list(),
                                                safe = TRUE,
                                                refresh = FALSE,
                                                flatten = FALSE,
                                                flatten_mode = "json") {
  response <- dip_bundestag_request("/vorgangsposition", params, safe, refresh)
  dip_bundestag_tidy_list(response, flatten, flatten_mode)
}

#' Get a DIP Vorgangsposition
#'
#' @param vorgangsposition_id Vorgangsposition id.
#' @inheritParams dip_bundestag_vorgang_list
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' dip_bundestag_vorgangsposition(173376)
#' }
#'
#' @return A one-row tibble for the selected Vorgangsposition:
#' \describe{
#'   \item{id}{Vorgangsposition identifier (character).}
#'   \item{vorgangsposition}{Step description (character).}
#'   \item{zuordnung}{Assignment: `"BT"`, `"BR"`, `"BV"`, or `"EK"` (character).}
#'   \item{gang}{Key step in the legislative process (logical).}
#'   \item{fortsetzung}{Continuation of a previous debate (logical).}
#'   \item{nachtrag}{Addendum entry (logical).}
#'   \item{vorgangstyp}{Parent Vorgang type (character).}
#'   \item{typ}{Entity type, always `"Vorgangsposition"` (character).}
#'   \item{titel}{Title of the parent Vorgang (character).}
#'   \item{dokumentart}{Document type: `"Drucksache"` or `"Plenarprotokoll"` (character).}
#'   \item{vorgang_id}{Parent Vorgang id (character).}
#'   \item{datum}{Date of associated document (character, ISO date).}
#'   \item{aktualisiert}{Last update timestamp (character, ISO datetime).}
#'   \item{fundstelle}{Document reference details (list-column).}
#'   \item{urheber}{Authoring bodies (list-column).}
#'   \item{ueberweisung}{Committee referrals (list-column).}
#'   \item{aktivitaet_anzeige}{Up to 4 associated activities for display (list-column).}
#'   \item{aktivitaet_anzahl}{Total number of associated activities (integer).}
#'   \item{ressort}{Government departments involved (list-column).}
#'   \item{beschlussfassung}{Voting decisions (list-column).}
#'   \item{ratsdok}{EU Council document number (character or `NA`).}
#'   \item{kom}{EU COM reference number (character or `NA`).}
#'   \item{sek}{EU SEC reference number (character or `NA`).}
#'   \item{mitberaten}{Co-deliberated Vorgangspositionen (list-column).}
#'   \item{abstract}{Summary text (character or `NA`).}
#' }
#' @family DIP Bundestag
#' @export
dip_bundestag_vorgangsposition <- function(vorgangsposition_id,
                                           params = list(),
                                           safe = TRUE,
                                           refresh = FALSE) {
  response <- dip_bundestag_request(
    "/vorgangsposition/{id}",
    params = c(list(id = vorgangsposition_id), params),
    safe = safe,
    refresh = refresh
  )
  dip_bundestag_tidy_detail(response)
}

#' List DIP Drucksachen
#'
#' @inheritParams dip_bundestag_vorgang_list
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
#' @examples
#' \dontrun{
#' dip_bundestag_drucksache_list()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per Drucksache and columns:
#'   \describe{
#'     \item{id}{Character. Unique Drucksache identifier.}
#'     \item{typ}{Character. Entity type, always `"Dokument"`.}
#'     \item{dokumentart}{Character. Document type, always `"Drucksache"`.}
#'     \item{drucksachetyp}{Character. Drucksache subtype.}
#'     \item{dokumentnummer}{Character. Document number.}
#'     \item{wahlperiode}{Integer. Legislative period.}
#'     \item{herausgeber}{Character. Publisher: `"BT"` or `"BR"`.}
#'     \item{datum}{Character. Publication date.}
#'     \item{aktualisiert}{Character. Last update timestamp.}
#'     \item{titel}{Character. Title text.}
#'     \item{autoren_anzahl}{Integer. Total author count.}
#'     \item{pdf_hash}{Character. MD5 checksum of PDF file.}
#'     \item{vorgangsbezug_anzahl}{Integer. Total related Vorgaenge.}
#'     \item{anlagen}{Character. Appendix description.}
#'     \item{autoren_anzeige}{List. Up to 4 display authors.}
#'     \item{fundstelle}{List. Document reference details.}
#'     \item{urheber}{List. Authoring bodies.}
#'     \item{vorgangsbezug}{List. Related Vorgaenge.}
#'     \item{ressort}{List. Government departments involved.}
#'   }
#'
#' Wrapped in a one-row tibble with `num_found` (integer), `cursor`
#' (character), and `documents` (list-column) when not yet unpacked.
#' @family DIP Bundestag
#' @export
dip_bundestag_drucksache_list <- function(params = list(),
                                          safe = TRUE,
                                          refresh = FALSE,
                                          flatten = FALSE,
                                          flatten_mode = "json") {
  response <- dip_bundestag_request("/drucksache", params, safe, refresh)
  dip_bundestag_tidy_list(response, flatten, flatten_mode)
}

#' Get a DIP Drucksache
#'
#' @param drucksache_id Drucksache id.
#' @inheritParams dip_bundestag_vorgang_list
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' dip_bundestag_drucksache(68852)
#' }
#'
#' @return A one-row tibble for the selected Drucksache:
#' \describe{
#'   \item{id}{Drucksache identifier (character).}
#'   \item{typ}{Entity type, always `"Dokument"` (character).}
#'   \item{dokumentart}{Document type, always `"Drucksache"` (character).}
#'   \item{drucksachetyp}{Drucksache subtype, e.g. `"Antrag"` (character).}
#'   \item{dokumentnummer}{Document number, e.g. `"19/1"` (character).}
#'   \item{wahlperiode}{Legislative period (integer).}
#'   \item{herausgeber}{Publisher: `"BT"` or `"BR"` (character).}
#'   \item{datum}{Publication date (character, ISO date).}
#'   \item{aktualisiert}{Last update timestamp (character, ISO datetime).}
#'   \item{titel}{Title (character).}
#'   \item{autoren_anzeige}{Up to 4 authors for display (list-column).}
#'   \item{autoren_anzahl}{Total author count (integer).}
#'   \item{fundstelle}{Document reference details (list-column).}
#'   \item{pdf_hash}{MD5 checksum of the PDF file (character or `NA`).}
#'   \item{urheber}{Authoring bodies (list-column).}
#'   \item{vorgangsbezug}{Up to 4 related Vorgänge (list-column).}
#'   \item{vorgangsbezug_anzahl}{Total number of related Vorgänge (integer).}
#'   \item{ressort}{Government departments involved (list-column).}
#'   \item{anlagen}{Appendix description (character or `NA`).}
#' }
#' @family DIP Bundestag
#' @export
dip_bundestag_drucksache <- function(drucksache_id,
                                     params = list(),
                                     safe = TRUE,
                                     refresh = FALSE) {
  response <- dip_bundestag_request(
    "/drucksache/{id}",
    params = c(list(id = drucksache_id), params),
    safe = safe,
    refresh = refresh
  )
  dip_bundestag_tidy_detail(response)
}

#' List DIP Drucksache texts
#'
#' @inheritParams dip_bundestag_vorgang_list
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
#' @examples
#' \dontrun{
#' dip_bundestag_drucksache_text_list()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per Drucksache text and columns:
#'   \describe{
#'     \item{id}{Character. Unique Drucksache identifier.}
#'     \item{typ}{Character. Entity type, always `"Dokument"`.}
#'     \item{dokumentart}{Character. Document type, always `"Drucksache"`.}
#'     \item{drucksachetyp}{Character. Drucksache subtype.}
#'     \item{dokumentnummer}{Character. Document number.}
#'     \item{wahlperiode}{Integer. Legislative period.}
#'     \item{herausgeber}{Character. Publisher: `"BT"` or `"BR"`.}
#'     \item{datum}{Character. Publication date.}
#'     \item{aktualisiert}{Character. Last update timestamp.}
#'     \item{titel}{Character. Title text.}
#'     \item{autoren_anzahl}{Integer. Total author count.}
#'     \item{pdf_hash}{Character. MD5 checksum of PDF file.}
#'     \item{vorgangsbezug_anzahl}{Integer. Total related Vorgaenge.}
#'     \item{anlagen}{Character. Appendix description.}
#'     \item{text}{Character. Full document text.}
#'     \item{autoren_anzeige}{List. Up to 4 display authors.}
#'     \item{fundstelle}{List. Document reference details.}
#'     \item{urheber}{List. Authoring bodies.}
#'     \item{vorgangsbezug}{List. Related Vorgaenge.}
#'     \item{ressort}{List. Government departments involved.}
#'   }
#'
#' Wrapped in a one-row tibble with `num_found` (integer), `cursor`
#' (character), and `documents` (list-column) when not yet unpacked.
#' @family DIP Bundestag
#' @export
dip_bundestag_drucksache_text_list <- function(params = list(),
                                               safe = TRUE,
                                               refresh = FALSE,
                                               flatten = FALSE,
                                               flatten_mode = "json") {
  response <- dip_bundestag_request("/drucksache-text", params, safe, refresh)
  dip_bundestag_tidy_list(response, flatten, flatten_mode)
}

#' Get a DIP Drucksache text
#'
#' @param drucksache_id Drucksache id.
#' @inheritParams dip_bundestag_vorgang_list
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' dip_bundestag_drucksache_text(68852)
#' }
#'
#' @return A one-row tibble for the selected Drucksache text record.
#' Contains all columns from [dip_bundestag_drucksache()] plus:
#' \describe{
#'   \item{text}{Full document text (character).}
#' }
#' @family DIP Bundestag
#' @export
dip_bundestag_drucksache_text <- function(drucksache_id,
                                          params = list(),
                                          safe = TRUE,
                                          refresh = FALSE) {
  response <- dip_bundestag_request(
    "/drucksache-text/{id}",
    params = c(list(id = drucksache_id), params),
    safe = safe,
    refresh = refresh
  )
  dip_bundestag_tidy_detail(response)
}

#' List DIP Plenarprotokolle
#'
#' @inheritParams dip_bundestag_vorgang_list
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
#' @examples
#' \dontrun{
#' dip_bundestag_plenarprotokoll_list()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per Plenarprotokoll and columns:
#'   \describe{
#'     \item{id}{Character. Unique Plenarprotokoll identifier.}
#'     \item{dokumentart}{Character. Document type, always `"Plenarprotokoll"`.}
#'     \item{typ}{Character. Entity type, always `"Dokument"`.}
#'     \item{dokumentnummer}{Character. Document number.}
#'     \item{wahlperiode}{Integer. Legislative period.}
#'     \item{datum}{Character. Session date.}
#'     \item{aktualisiert}{Character. Last update timestamp.}
#'     \item{titel}{Character. Title text.}
#'     \item{pdf_hash}{Character. MD5 checksum of PDF file.}
#'     \item{vorgangsbezug_anzahl}{Integer. Total related Vorgaenge.}
#'     \item{sitzungsbemerkung}{Character. Session remark.}
#'     \item{herausgeber}{List. Publisher assignment.}
#'     \item{fundstelle}{List. Document reference details.}
#'     \item{vorgangsbezug}{List. Related Vorgaenge.}
#'   }
#'
#' Wrapped in a one-row tibble with `num_found` (integer), `cursor`
#' (character), and `documents` (list-column) when not yet unpacked.
#' @family DIP Bundestag
#' @export
dip_bundestag_plenarprotokoll_list <- function(params = list(),
                                               safe = TRUE,
                                               refresh = FALSE,
                                               flatten = FALSE,
                                               flatten_mode = "json") {
  response <- dip_bundestag_request("/plenarprotokoll", params, safe, refresh)
  dip_bundestag_tidy_list(response, flatten, flatten_mode)
}

#' Get a DIP Plenarprotokoll
#'
#' @param plenarprotokoll_id Plenarprotokoll id.
#' @inheritParams dip_bundestag_vorgang_list
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' dip_bundestag_plenarprotokoll(908)
#' }
#'
#' @return A one-row tibble for the selected Plenarprotokoll:
#' \describe{
#'   \item{id}{Plenarprotokoll identifier (character).}
#'   \item{dokumentart}{Document type, always `"Plenarprotokoll"` (character).}
#'   \item{typ}{Entity type, always `"Dokument"` (character).}
#'   \item{dokumentnummer}{Document number, e.g. `"19/1"` (character).}
#'   \item{wahlperiode}{Legislative period (integer).}
#'   \item{herausgeber}{Publisher assignment (character).}
#'   \item{datum}{Session date (character, ISO date).}
#'   \item{aktualisiert}{Last update timestamp (character, ISO datetime).}
#'   \item{titel}{Title (character).}
#'   \item{fundstelle}{Document reference details (list-column).}
#'   \item{pdf_hash}{MD5 checksum of the PDF file (character or `NA`).}
#'   \item{vorgangsbezug}{Up to 4 related Vorgänge (list-column).}
#'   \item{vorgangsbezug_anzahl}{Total number of related Vorgänge (integer).}
#'   \item{sitzungsbemerkung}{Session remark, e.g. `"Sondersitzung"` (character or `NA`).}
#' }
#' @family DIP Bundestag
#' @export
dip_bundestag_plenarprotokoll <- function(plenarprotokoll_id,
                                          params = list(),
                                          safe = TRUE,
                                          refresh = FALSE) {
  response <- dip_bundestag_request(
    "/plenarprotokoll/{id}",
    params = c(list(id = plenarprotokoll_id), params),
    safe = safe,
    refresh = refresh
  )
  dip_bundestag_tidy_detail(response)
}

#' List DIP Plenarprotokoll texts
#'
#' @inheritParams dip_bundestag_vorgang_list
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
#' @examples
#' \dontrun{
#' dip_bundestag_plenarprotokoll_text_list()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per Plenarprotokoll text and columns:
#'   \describe{
#'     \item{id}{Character. Unique Plenarprotokoll identifier.}
#'     \item{dokumentart}{Character. Document type, always `"Plenarprotokoll"`.}
#'     \item{typ}{Character. Entity type, always `"Dokument"`.}
#'     \item{dokumentnummer}{Character. Document number.}
#'     \item{wahlperiode}{Integer. Legislative period.}
#'     \item{datum}{Character. Session date.}
#'     \item{aktualisiert}{Character. Last update timestamp.}
#'     \item{titel}{Character. Title text.}
#'     \item{pdf_hash}{Character. MD5 checksum of PDF file.}
#'     \item{vorgangsbezug_anzahl}{Integer. Total related Vorgaenge.}
#'     \item{sitzungsbemerkung}{Character. Session remark.}
#'     \item{text}{Character. Full document text.}
#'     \item{herausgeber}{List. Publisher assignment.}
#'     \item{fundstelle}{List. Document reference details.}
#'     \item{vorgangsbezug}{List. Related Vorgaenge.}
#'   }
#'
#' Wrapped in a one-row tibble with `num_found` (integer), `cursor`
#' (character), and `documents` (list-column) when not yet unpacked.
#' @family DIP Bundestag
#' @export
dip_bundestag_plenarprotokoll_text_list <- function(params = list(),
                                                    safe = TRUE,
                                                    refresh = FALSE,
                                                    flatten = FALSE,
                                                    flatten_mode = "json") {
  response <- dip_bundestag_request("/plenarprotokoll-text", params, safe, refresh)
  dip_bundestag_tidy_list(response, flatten, flatten_mode)
}

#' Get a DIP Plenarprotokoll text
#'
#' @param plenarprotokoll_id Plenarprotokoll id.
#' @inheritParams dip_bundestag_vorgang_list
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' dip_bundestag_plenarprotokoll_text(908)
#' }
#'
#' @return A one-row tibble for the selected Plenarprotokoll text record.
#' Contains all columns from [dip_bundestag_plenarprotokoll()] plus:
#' \describe{
#'   \item{text}{Full document text (character).}
#' }
#' @family DIP Bundestag
#' @export
dip_bundestag_plenarprotokoll_text <- function(plenarprotokoll_id,
                                               params = list(),
                                               safe = TRUE,
                                               refresh = FALSE) {
  response <- dip_bundestag_request(
    "/plenarprotokoll-text/{id}",
    params = c(list(id = plenarprotokoll_id), params),
    safe = safe,
    refresh = refresh
  )
  dip_bundestag_tidy_detail(response)
}

#' List DIP Aktivitäten
#'
#' @inheritParams dip_bundestag_vorgang_list
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
#' @examples
#' \dontrun{
#' dip_bundestag_aktivitaet_list()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per Aktivitaet and columns:
#'   \describe{
#'     \item{id}{Character. Unique Aktivitaet identifier.}
#'     \item{aktivitaetsart}{Character. Activity type.}
#'     \item{typ}{Character. Entity type, always `"Aktivitaet"`.}
#'     \item{dokumentart}{Character. Document type.}
#'     \item{wahlperiode}{Integer. Legislative period.}
#'     \item{datum}{Character. Date of associated document.}
#'     \item{aktualisiert}{Character. Last update timestamp.}
#'     \item{titel}{Character. Title text.}
#'     \item{vorgangsbezug_anzahl}{Integer. Total related Vorgaenge.}
#'     \item{abstract}{Character. Summary text.}
#'     \item{fundstelle}{List. Document reference details.}
#'     \item{vorgangsbezug}{List. Related Vorgaenge.}
#'     \item{deskriptor}{List. Thesaurus descriptor entries.}
#'   }
#'
#' Wrapped in a one-row tibble with `num_found` (integer), `cursor`
#' (character), and `documents` (list-column) when not yet unpacked.
#' @family DIP Bundestag
#' @export
dip_bundestag_aktivitaet_list <- function(params = list(),
                                          safe = TRUE,
                                          refresh = FALSE,
                                          flatten = FALSE,
                                          flatten_mode = "json") {
  response <- dip_bundestag_request("/aktivitaet", params, safe, refresh)
  dip_bundestag_tidy_list(response, flatten, flatten_mode)
}

#' Get a DIP Aktivität
#'
#' @param aktivitaet_id Aktivität id.
#' @inheritParams dip_bundestag_vorgang_list
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' dip_bundestag_aktivitaet(1493545)
#' }
#'
#' @return A one-row tibble for the selected Aktivitaet:
#' \describe{
#'   \item{id}{Aktivitaet identifier (character).}
#'   \item{aktivitaetsart}{Activity type, e.g. `"Rede"` (character).}
#'   \item{typ}{Entity type, always `"Aktivität"` (character).}
#'   \item{dokumentart}{Document type: `"Drucksache"` or `"Plenarprotokoll"` (character).}
#'   \item{wahlperiode}{Legislative period (integer).}
#'   \item{datum}{Date of associated document (character, ISO date).}
#'   \item{aktualisiert}{Last update timestamp (character, ISO datetime).}
#'   \item{titel}{Title (character).}
#'   \item{fundstelle}{Document reference details (list-column).}
#'   \item{vorgangsbezug}{Up to 4 related Vorgänge (list-column).}
#'   \item{vorgangsbezug_anzahl}{Total number of related Vorgänge (integer).}
#'   \item{deskriptor}{Thesaurus descriptors (list-column).}
#'   \item{abstract}{Summary text (character or `NA`).}
#' }
#' @family DIP Bundestag
#' @export
dip_bundestag_aktivitaet <- function(aktivitaet_id,
                                     params = list(),
                                     safe = TRUE,
                                     refresh = FALSE) {
  response <- dip_bundestag_request(
    "/aktivitaet/{id}",
    params = c(list(id = aktivitaet_id), params),
    safe = safe,
    refresh = refresh
  )
  dip_bundestag_tidy_detail(response)
}

#' List DIP Personen
#'
#' @inheritParams dip_bundestag_vorgang_list
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
#' @examples
#' \dontrun{
#' dip_bundestag_person_list()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per Person and columns:
#'   \describe{
#'     \item{id}{Character. Unique person identifier.}
#'     \item{nachname}{Character. Last name.}
#'     \item{vorname}{Character. First name.}
#'     \item{namenszusatz}{Character. Name affix.}
#'     \item{typ}{Character. Entity type, always `"Person"`.}
#'     \item{wahlperiode}{Integer. Legislative period of first document.}
#'     \item{basisdatum}{Character. Date of first associated document.}
#'     \item{datum}{Character. Date of most recent document.}
#'     \item{aktualisiert}{Character. Last update timestamp.}
#'     \item{titel}{Character. Display title with role.}
#'     \item{person_roles}{List. Roles and alternative names.}
#'   }
#'
#' Wrapped in a one-row tibble with `num_found` (integer), `cursor`
#' (character), and `documents` (list-column) when not yet unpacked.
#' @family DIP Bundestag
#' @export
dip_bundestag_person_list <- function(params = list(),
                                      safe = TRUE,
                                      refresh = FALSE,
                                      flatten = FALSE,
                                      flatten_mode = "json") {
  response <- dip_bundestag_request("/person", params, safe, refresh)
  dip_bundestag_tidy_list(response, flatten, flatten_mode)
}

#' Get a DIP Person
#'
#' @param person_id Person id.
#' @inheritParams dip_bundestag_vorgang_list
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' dip_bundestag_person(1728)
#' }
#'
#' @return A one-row tibble for the selected person:
#' \describe{
#'   \item{id}{Person identifier (character).}
#'   \item{nachname}{Last name (character).}
#'   \item{vorname}{First name (character).}
#'   \item{namenszusatz}{Name affix, e.g. `"von der"` (character or `NA`).}
#'   \item{typ}{Entity type, always `"Person"` (character).}
#'   \item{wahlperiode}{Legislative period of first associated document (integer or `NA`).}
#'   \item{basisdatum}{Date of first associated document (character or `NA`).}
#'   \item{datum}{Date of most recent associated document (character or `NA`).}
#'   \item{aktualisiert}{Last update timestamp (character, ISO datetime).}
#'   \item{titel}{Display title with role (character).}
#'   \item{person_roles}{Roles and alternative names (list-column).}
#' }
#' @family DIP Bundestag
#' @export
dip_bundestag_person <- function(person_id,
                                 params = list(),
                                 safe = TRUE,
                                 refresh = FALSE) {
  response <- dip_bundestag_request(
    "/person/{id}",
    params = c(list(id = person_id), params),
    safe = safe,
    refresh = refresh
  )
  dip_bundestag_tidy_detail(response)
}

dip_bundestag_request <- function(path,
                                  params = list(),
                                  safe = TRUE,
                                  refresh = FALSE,
                                  parse = "json") {
  # Set default format parameter
  if (is.null(params$format)) {
    params$format <- "json"
  }

  # bunddev_call() handles auth via bunddev_auth_get/header automatically
  # Configure auth via: bunddev_auth_set("dip_bundestag", type = "api_key",
  #                                      env_var = "DIP_BUNDESTAG_API_KEY", scheme = "ApiKey")

  auth <- bunddev_auth_get("dip_bundestag")
  if (auth$type == "none") {
    # Legacy fallback: check params or env var directly
    api_key <- dip_bundestag_api_key(params)
    if (!is.null(api_key)) {
      bunddev_call(
        "dip_bundestag",
        path = path,
        method = "GET",
        params = params,
        headers = list(Authorization = paste("ApiKey", api_key)),
        parse = parse,
        safe = safe,
        refresh = refresh
      )
    } else {
      bunddev_call(
        "dip_bundestag",
        path = path,
        method = "GET",
        params = params,
        parse = parse,
        safe = safe,
        refresh = refresh
      )
    }
  } else {
    bunddev_call(
      "dip_bundestag",
      path = path,
      method = "GET",
      params = params,
      parse = parse,
      safe = safe,
      refresh = refresh
    )
  }
}

dip_bundestag_api_key <- function(params) {
  if (!is.null(params$apikey) && params$apikey != "") {
    return(params$apikey)
  }

  auth <- bunddev_auth_get("dip_bundestag")
  if (auth$type == "api_key") {
    api_key <- Sys.getenv(auth$env_var)
    if (api_key == "") {
      cli::cli_abort("Environment variable '{auth$env_var}' is not set.")
    }
    return(api_key)
  }

  api_key <- Sys.getenv("DIP_BUNDESTAG_API_KEY")
  if (api_key == "") {
    cli::cli_abort("DIP_BUNDESTAG_API_KEY is not set.")
  }
  api_key
}

dip_bundestag_tidy_list <- function(response, flatten, flatten_mode) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  data <- tibble::tibble(
    num_found = response$numFound %||% NA_integer_,
    cursor = response$cursor %||% NA_character_,
    documents = list(response$documents %||% list())
  )

  if (flatten) {
    return(bunddev_flatten_list_cols(data, cols = "documents", mode = flatten_mode))
  }

  data
}

dip_bundestag_tidy_detail <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  cleaned <- purrr::map(response, function(x) {
    if (is.null(x)) return(NA)
    if (is.list(x) || length(x) > 1) return(list(x))
    x
  })
  tibble::as_tibble(cleaned)
}

bunddev_dip_bundestag_vorgang_list <- function(params = list(),
                                               safe = TRUE,
                                               refresh = FALSE,
                                               flatten = FALSE,
                                               flatten_mode = "json") {
  dip_bundestag_vorgang_list(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_dip_bundestag_vorgang <- function(vorgang_id,
                                          params = list(),
                                          safe = TRUE,
                                          refresh = FALSE) {
  dip_bundestag_vorgang(
    vorgang_id = vorgang_id,
    params = params,
    safe = safe,
    refresh = refresh
  )
}

bunddev_dip_bundestag_vorgangsposition_list <- function(params = list(),
                                                        safe = TRUE,
                                                        refresh = FALSE,
                                                        flatten = FALSE,
                                                        flatten_mode = "json") {
  dip_bundestag_vorgangsposition_list(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_dip_bundestag_vorgangsposition <- function(vorgangsposition_id,
                                                   params = list(),
                                                   safe = TRUE,
                                                   refresh = FALSE) {
  dip_bundestag_vorgangsposition(
    vorgangsposition_id = vorgangsposition_id,
    params = params,
    safe = safe,
    refresh = refresh
  )
}

bunddev_dip_bundestag_drucksache_list <- function(params = list(),
                                                  safe = TRUE,
                                                  refresh = FALSE,
                                                  flatten = FALSE,
                                                  flatten_mode = "json") {
  dip_bundestag_drucksache_list(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_dip_bundestag_drucksache <- function(drucksache_id,
                                             params = list(),
                                             safe = TRUE,
                                             refresh = FALSE) {
  dip_bundestag_drucksache(
    drucksache_id = drucksache_id,
    params = params,
    safe = safe,
    refresh = refresh
  )
}

bunddev_dip_bundestag_drucksache_text_list <- function(params = list(),
                                                       safe = TRUE,
                                                       refresh = FALSE,
                                                       flatten = FALSE,
                                                       flatten_mode = "json") {
  dip_bundestag_drucksache_text_list(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_dip_bundestag_drucksache_text <- function(drucksache_id,
                                                  params = list(),
                                                  safe = TRUE,
                                                  refresh = FALSE) {
  dip_bundestag_drucksache_text(
    drucksache_id = drucksache_id,
    params = params,
    safe = safe,
    refresh = refresh
  )
}

bunddev_dip_bundestag_plenarprotokoll_list <- function(params = list(),
                                                       safe = TRUE,
                                                       refresh = FALSE,
                                                       flatten = FALSE,
                                                       flatten_mode = "json") {
  dip_bundestag_plenarprotokoll_list(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_dip_bundestag_plenarprotokoll <- function(plenarprotokoll_id,
                                                  params = list(),
                                                  safe = TRUE,
                                                  refresh = FALSE) {
  dip_bundestag_plenarprotokoll(
    plenarprotokoll_id = plenarprotokoll_id,
    params = params,
    safe = safe,
    refresh = refresh
  )
}

bunddev_dip_bundestag_plenarprotokoll_text_list <- function(params = list(),
                                                            safe = TRUE,
                                                            refresh = FALSE,
                                                            flatten = FALSE,
                                                            flatten_mode = "json") {
  dip_bundestag_plenarprotokoll_text_list(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_dip_bundestag_plenarprotokoll_text <- function(plenarprotokoll_id,
                                                       params = list(),
                                                       safe = TRUE,
                                                       refresh = FALSE) {
  dip_bundestag_plenarprotokoll_text(
    plenarprotokoll_id = plenarprotokoll_id,
    params = params,
    safe = safe,
    refresh = refresh
  )
}

bunddev_dip_bundestag_aktivitaet_list <- function(params = list(),
                                                  safe = TRUE,
                                                  refresh = FALSE,
                                                  flatten = FALSE,
                                                  flatten_mode = "json") {
  dip_bundestag_aktivitaet_list(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_dip_bundestag_aktivitaet <- function(aktivitaet_id,
                                             params = list(),
                                             safe = TRUE,
                                             refresh = FALSE) {
  dip_bundestag_aktivitaet(
    aktivitaet_id = aktivitaet_id,
    params = params,
    safe = safe,
    refresh = refresh
  )
}

bunddev_dip_bundestag_person_list <- function(params = list(),
                                              safe = TRUE,
                                              refresh = FALSE,
                                              flatten = FALSE,
                                              flatten_mode = "json") {
  dip_bundestag_person_list(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_dip_bundestag_person <- function(person_id,
                                         params = list(),
                                         safe = TRUE,
                                         refresh = FALSE) {
  dip_bundestag_person(
    person_id = person_id,
    params = params,
    safe = safe,
    refresh = refresh
  )
}
