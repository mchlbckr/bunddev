#' List Hilfsmittel tree nodes
#'
#' @param level Tree level to retrieve (1-4).
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns nodes from the Hilfsmittel product tree up to the selected level.
#' API documentation: \url{https://github.com/bundesAPI/hilfsmittel-api}.
#'
#' @examples
#' \dontrun{
#' hilfsmittel_tree(level = 1)
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per tree node and columns:
#'   \describe{
#'     \item{id}{Character. Node identifier.}
#'     \item{parentId}{Character. Parent node identifier (`NA` for roots).}
#'     \item{displayValue}{Character. Node display label.}
#'     \item{xStellerDisplayValue}{Character. xSteller with label.}
#'     \item{xSteller}{Character. Position code of the node.}
#'     \item{level}{Integer. Tree depth level.}
#'   }
#' @family Hilfsmittel
#' @export
hilfsmittel_tree <- function(level, safe = TRUE, refresh = FALSE) {
  response <- hilfsmittel_request(
    path = "/VerzeichnisTree/{level}",
    params = list(level = level),
    safe = safe,
    refresh = refresh
  )

  hilfsmittel_tidy_response(response)
}

#' Get Hilfsmittel product group details
#'
#' @param id Produktgruppe id.
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
#' Returns details for a product group (Produktgruppe).
#' API documentation: \url{https://github.com/bundesAPI/hilfsmittel-api}.
#'
#' @examples
#' \dontrun{
#' tree <- hilfsmittel_tree(level = 1)
#' hilfsmittel_produktgruppe(tree$id[[1]])
#' }
#'
#' @return A [tibble][tibble::tibble] with one row for the requested product
#'   group and columns:
#'   \describe{
#'     \item{id}{Character. Product group identifier.}
#'     \item{versionId}{Character. Internal version identifier.}
#'     \item{bezeichnung}{Character. Product group name.}
#'     \item{nummer}{Integer. Product group number.}
#'     \item{definition}{Character. Description text.}
#'     \item{indikation}{Character. Indication text.}
#'     \item{querverweis}{Character. Cross-reference to other groups.}
#'     \item{isNnElement}{Logical. Internal flag (usage unclear).}
#'     \item{sachbearbeiterGkvId}{Character. GKV case-worker identifier.}
#'     \item{sachbearbeiterGkv}{Character. Always `NA`.}
#'     \item{sachbearbeiterMdsId}{Character. MDS case-worker identifier.}
#'     \item{sachbearbeiterMds}{Character. Always `NA`.}
#'     \item{aufnahmeDatum}{Character. Admission date (ISO-8601).}
#'     \item{aenderungsDatum}{Character. Last-modified date (ISO-8601).}
#'     \item{veroeffentlichungsDokumentFileStoreId}{Character. Publication document id.}
#'     \item{merkblattFileStoreId}{Character. Always `NA`.}
#'     \item{isCollectionReviewable}{Logical. Internal flag (usage unclear).}
#'     \item{aufnahmeDatum_time}{POSIXct. Parsed admission date (Europe/Berlin).}
#'     \item{aenderungsDatum_time}{POSIXct. Parsed last-modified date (Europe/Berlin).}
#'   }
#' @family Hilfsmittel
#' @export
hilfsmittel_produktgruppe <- function(id,
                                      safe = TRUE,
                                      refresh = FALSE,
                                      flatten = FALSE,
                                      flatten_mode = "json") {
  response <- hilfsmittel_request(
    path = "/Produktgruppe/{id}",
    params = list(id = id),
    safe = safe,
    refresh = refresh
  )

  hilfsmittel_maybe_flatten(hilfsmittel_tidy_response(response), flatten, flatten_mode)
}

#' Get Hilfsmittel subgroup details
#'
#' @param id Untergruppe id.
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
#' Returns details for a subgroup (Untergruppe).
#' API documentation: \url{https://github.com/bundesAPI/hilfsmittel-api}.
#'
#' @examples
#' \dontrun{
#' hilfsmittel_untergruppe("c92d1976-d3cb-4b9f-bcdf-805272a9ea86")
#' }
#'
#' @return A [tibble][tibble::tibble] with one row for the requested subgroup
#'   and columns:
#'   \describe{
#'     \item{id}{Character. Subgroup identifier.}
#'     \item{versionId}{Character. Internal version identifier.}
#'     \item{nummer}{Integer. Subgroup number.}
#'     \item{anwendungsortId}{Character. Application-site identifier.}
#'     \item{bezeichnung}{Character. Subgroup name.}
#'     \item{produktgruppeId}{Character. Parent product-group identifier.}
#'     \item{nachweisschemaId}{Character. Verification-schema identifier.}
#'     \item{sechsSteller}{Character. Six-digit code.}
#'     \item{isNnElement}{Logical. Internal flag (usage unclear).}
#'     \item{produktgruppe}{Numeric. Always `NA`.}
#'     \item{anwendungsort}{Numeric. Always `NA`.}
#'     \item{aufnahmeDatum}{Character. Admission date (ISO-8601).}
#'     \item{aenderungsDatum}{Character. Last-modified date (ISO-8601).}
#'     \item{aufnahmeDatum_time}{POSIXct. Parsed admission date (Europe/Berlin).}
#'     \item{aenderungsDatum_time}{POSIXct. Parsed last-modified date (Europe/Berlin).}
#'   }
#' @family Hilfsmittel
#' @export
hilfsmittel_untergruppe <- function(id,
                                    safe = TRUE,
                                    refresh = FALSE,
                                    flatten = FALSE,
                                    flatten_mode = "json") {
  response <- hilfsmittel_request(
    path = "/Untergruppe/{id}",
    params = list(id = id),
    safe = safe,
    refresh = refresh
  )

  hilfsmittel_maybe_flatten(hilfsmittel_tidy_response(response), flatten, flatten_mode)
}

#' Get Hilfsmittel product type details
#'
#' @param id Produktart id.
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
#' Returns details for a product type (Produktart).
#' API documentation: \url{https://github.com/bundesAPI/hilfsmittel-api}.
#'
#' @examples
#' \dontrun{
#' hilfsmittel_produktart("e6b913ef-cf21-4c5f-826d-f866516c3c65")
#' }
#'
#' @return A [tibble][tibble::tibble] with one row for the requested product
#'   type and columns:
#'   \describe{
#'     \item{id}{Character. Product-type identifier.}
#'     \item{versionId}{Character. Internal version identifier.}
#'     \item{nummer}{Integer. Product-type number.}
#'     \item{beschreibung}{Character. Description text.}
#'     \item{bezeichnung}{Character. Product-type name.}
#'     \item{untergruppeId}{Character. Parent subgroup identifier.}
#'     \item{indikation}{Character. Indication text.}
#'     \item{siebenSteller}{Character. Seven-digit code.}
#'     \item{isNnElement}{Logical. Internal flag (usage unclear).}
#'     \item{konstruktionsmerkmalschemaId}{Character. Construction-feature schema id.}
#'     \item{untergruppe}{Integer. Always `NA`.}
#'     \item{aufnahmeDatum}{Character. Admission date (ISO-8601).}
#'     \item{aenderungsDatum}{Character. Last-modified date (ISO-8601).}
#'     \item{aufnahmeDatum_time}{POSIXct. Parsed admission date (Europe/Berlin).}
#'     \item{aenderungsDatum_time}{POSIXct. Parsed last-modified date (Europe/Berlin).}
#'   }
#' @family Hilfsmittel
#' @export
hilfsmittel_produktart <- function(id,
                                   safe = TRUE,
                                   refresh = FALSE,
                                   flatten = FALSE,
                                   flatten_mode = "json") {
  response <- hilfsmittel_request(
    path = "/Produktart/{id}",
    params = list(id = id),
    safe = safe,
    refresh = refresh
  )

  hilfsmittel_maybe_flatten(hilfsmittel_tidy_response(response), flatten, flatten_mode)
}

#' List Hilfsmittel products
#'
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
#' Returns the full product list (large payload). API documentation: \url{https://github.com/bundesAPI/hilfsmittel-api}.
#'
#' @examples
#' \dontrun{
#' hilfsmittel_produkte()
#' }
#'
#' @return A [tibble][tibble::tibble] with one row per product and columns:
#'   \describe{
#'     \item{organisationId}{Character. Organisation identifier.}
#'     \item{produktartId}{Character. Product-type identifier.}
#'     \item{nummer}{Integer. Sequential product number.}
#'     \item{name}{Character. Product name.}
#'     \item{artikelnummern}{List. Article numbers (character vector).}
#'     \item{typenAusfuehrungen}{List. Type/model variants (character vector).}
#'     \item{aufnahmeDatum}{Character. Admission date (ISO-8601).}
#'     \item{aenderungsDatum}{Character. Last-modified date (ISO-8601).}
#'     \item{zehnSteller}{Character. Ten-digit product code.}
#'     \item{herstellerName}{Character. Manufacturer name.}
#'     \item{istHerausgenommen}{Logical. Whether product is withdrawn.}
#'     \item{istAbrechnungsposition}{Logical. Whether product is a billing item.}
#'     \item{id}{Character. Product identifier.}
#'     \item{displayName}{Character. Combined display label.}
#'     \item{aufnahmeDatum_time}{POSIXct. Parsed admission date (Europe/Berlin).}
#'     \item{aenderungsDatum_time}{POSIXct. Parsed last-modified date (Europe/Berlin).}
#'   }
#' @family Hilfsmittel
#' @export
hilfsmittel_produkte <- function(safe = TRUE,
                                 refresh = FALSE,
                                 flatten = FALSE,
                                 flatten_mode = "json") {
  response <- hilfsmittel_request(
    path = "/Produkt",
    params = list(),
    safe = safe,
    refresh = refresh
  )

  hilfsmittel_maybe_flatten(hilfsmittel_tidy_response(response), flatten, flatten_mode)
}

#' Get Hilfsmittel product details
#'
#' @param id Produkt id.
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
#' Returns detail information for a single product.
#' API documentation: \url{https://github.com/bundesAPI/hilfsmittel-api}.
#'
#' @examples
#' \dontrun{
#' hilfsmittel_produkt("f41f52a6-5d2d-4dd3-9d0e-39675ceca7f3")
#' }
#'
#' @return A [tibble][tibble::tibble] with one row for the requested product
#'   and columns:
#'   \describe{
#'     \item{organisationId}{Character. Organisation identifier.}
#'     \item{produktartId}{Character. Product-type identifier.}
#'     \item{nummer}{Integer. Sequential product number.}
#'     \item{name}{Character. Product name.}
#'     \item{artikelnummern}{List. Article numbers (character vector).}
#'     \item{typenAusfuehrungen}{List. Type/model variants (character vector).}
#'     \item{aufnahmeDatum}{Character. Admission date (ISO-8601).}
#'     \item{aenderungsDatum}{Character. Last-modified date (ISO-8601).}
#'     \item{zehnSteller}{Character. Ten-digit product code.}
#'     \item{herstellerName}{Character. Manufacturer name.}
#'     \item{istHerausgenommen}{Logical. Whether product is withdrawn.}
#'     \item{istAbrechnungsposition}{Logical. Whether product is a billing item.}
#'     \item{id}{Character. Product identifier.}
#'     \item{displayName}{Character. Combined display label.}
#'     \item{produktgruppeNummer}{Integer. Product-group number.}
#'     \item{anwendungsortNummer}{Integer. Application-site number.}
#'     \item{untergruppeNummer}{Integer. Subgroup number.}
#'     \item{produktartNummer}{Integer. Product-type number.}
#'     \item{produktartBezeichnung}{Character. Product-type name.}
#'     \item{kontruktionsmerkmale}{List. Construction features (nested objects).}
#'     \item{aufnahmeDatum_time}{POSIXct. Parsed admission date (Europe/Berlin).}
#'     \item{aenderungsDatum_time}{POSIXct. Parsed last-modified date (Europe/Berlin).}
#'   }
#' @family Hilfsmittel
#' @export
hilfsmittel_produkt <- function(id,
                                safe = TRUE,
                                refresh = FALSE,
                                flatten = FALSE,
                                flatten_mode = "json") {
  response <- hilfsmittel_request(
    path = "/Produkt/{id}",
    params = list(id = id),
    safe = safe,
    refresh = refresh
  )

  hilfsmittel_maybe_flatten(hilfsmittel_tidy_response(response), flatten, flatten_mode)
}

#' Get Hilfsmittel verification schema details
#'
#' @param id Nachweisschema id.
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
#' Returns detail information for a Nachweisschema.
#' API documentation: \url{https://github.com/bundesAPI/hilfsmittel-api}.
#'
#' @examples
#' \dontrun{
#' hilfsmittel_nachweisschema("a3d37017-2c91-4d6d-bbbe-4002d2868044")
#' }
#'
#' @return A [tibble][tibble::tibble] with one row for the requested
#'   verification schema and columns:
#'   \describe{
#'     \item{id}{Character. Schema identifier.}
#'     \item{name}{Character. Schema name.}
#'     \item{produktmusterErforderlich}{Logical. Whether a product sample is required.}
#'     \item{nachweisschemaKategorieZuweisungen}{List. Category assignments (nested objects).}
#'     \item{nachweisAbschnittAnforderungen}{List. Section requirements (nested objects).}
#'   }
#' @family Hilfsmittel
#' @export
hilfsmittel_nachweisschema <- function(id,
                                       safe = TRUE,
                                       refresh = FALSE,
                                       flatten = FALSE,
                                       flatten_mode = "json") {
  response <- hilfsmittel_request(
    path = "/Nachweisschema/{id}",
    params = list(id = id),
    safe = safe,
    refresh = refresh
  )

  hilfsmittel_maybe_flatten(hilfsmittel_tidy_response(response), flatten, flatten_mode)
}

hilfsmittel_request <- function(path,
                              params = list(),
                              safe = TRUE,
                              refresh = FALSE,
                              parse = "json") {
  bunddev_call(
    "hilfsmittel",
    path = path,
    method = "GET",
    params = params,
    parse = parse,
    safe = safe,
    refresh = refresh
  )
}

bunddev_hilfsmittel_tree <- function(level, safe = TRUE, refresh = FALSE) {
  hilfsmittel_request("/api/v1/tree", safe = safe, refresh = refresh)
}

hilfsmittel_tidy_response <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  is_list_of_lists <- function(value) {
    is.list(value) && length(value) > 0 && all(purrr::map_lgl(value, is.list))
  }

  if (is_list_of_lists(response)) {
    data <- purrr::map_dfr(response, function(item) {
      cleaned <- purrr::map(item, ~ if (is.null(.x)) NA else .x)
      tibble::as_tibble(cleaned)
    })
  } else {
    cleaned <- purrr::map(response, ~ if (is.null(.x)) NA else .x)
    data <- tibble::as_tibble(cleaned)
  }

  hilfsmittel_add_time_cols(data)
}

hilfsmittel_add_time_cols <- function(data) {
  time_fields <- c("aufnahmeDatum", "aenderungsDatum")
  fields <- intersect(time_fields, names(data))
  if (length(fields) == 0) {
    return(data)
  }

  for (field in fields) {
    data[[paste0(field, "_time")]] <- as.POSIXct(data[[field]], tz = "Europe/Berlin")
  }

  data
}

hilfsmittel_maybe_flatten <- function(data, flatten, flatten_mode) {
  if (!isTRUE(flatten)) {
    return(data)
  }

  list_cols <- names(data)[purrr::map_lgl(data, is.list)]
  bunddev_flatten_list_cols(data, cols = list_cols, mode = flatten_mode)
}

bunddev_hilfsmittel_tree <- function(level, safe = TRUE, refresh = FALSE) {
  hilfsmittel_tree(level = level, safe = safe, refresh = refresh)
}

bunddev_hilfsmittel_produktgruppe <- function(id,
                                              safe = TRUE,
                                              refresh = FALSE,
                                              flatten = FALSE,
                                              flatten_mode = "json") {
  hilfsmittel_produktgruppe(
    id = id,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_hilfsmittel_untergruppe <- function(id,
                                            safe = TRUE,
                                            refresh = FALSE,
                                            flatten = FALSE,
                                            flatten_mode = "json") {
  hilfsmittel_untergruppe(
    id = id,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_hilfsmittel_produktart <- function(id,
                                           safe = TRUE,
                                           refresh = FALSE,
                                           flatten = FALSE,
                                           flatten_mode = "json") {
  hilfsmittel_produktart(
    id = id,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_hilfsmittel_produkte <- function(safe = TRUE,
                                         refresh = FALSE,
                                         flatten = FALSE,
                                         flatten_mode = "json") {
  hilfsmittel_produkte(
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_hilfsmittel_produkt <- function(id,
                                        safe = TRUE,
                                        refresh = FALSE,
                                        flatten = FALSE,
                                        flatten_mode = "json") {
  hilfsmittel_produkt(
    id = id,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_hilfsmittel_nachweisschema <- function(id,
                                               safe = TRUE,
                                               refresh = FALSE,
                                               flatten = FALSE,
                                               flatten_mode = "json") {
  hilfsmittel_nachweisschema(
    id = id,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}
