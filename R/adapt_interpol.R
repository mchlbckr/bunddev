#' List Interpol red notices
#'
#' @param params Query parameters.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' Returns Interpol red notices. Official docs:
#' https://interpol.api.bund.dev.
#'
#' @examples
#' \dontrun{
#' interpol_red_notices(params = list(resultPerPage = 10, page = 1))
#' }
#'
#' @return A tibble with notices metadata.
#' @export
interpol_red_notices <- function(params = list(),
                                 safe = TRUE,
                                 refresh = FALSE,
                                 flatten = FALSE,
                                 flatten_mode = "json") {
  response <- interpol_request(
    path = "/notices/v1/red",
    params = params,
    safe = safe,
    refresh = refresh
  )

  interpol_maybe_flatten(interpol_tidy_list_response(response), flatten, flatten_mode)
}

#' Get an Interpol red notice
#'
#' @param notice_id Notice ID.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' Returns detailed data for a red notice.
#' Official docs: https://interpol.api.bund.dev.
#'
#' @examples
#' \dontrun{
#' interpol_red_notice("1993-27493")
#' }
#'
#' @return A tibble with notice details.
#' @export
interpol_red_notice <- function(notice_id,
                                safe = TRUE,
                                refresh = FALSE,
                                flatten = FALSE,
                                flatten_mode = "json") {
  response <- interpol_request(
    path = "/notices/v1/red/{noticeID}",
    params = list(noticeID = notice_id),
    safe = safe,
    refresh = refresh
  )

  interpol_maybe_flatten(interpol_tidy_detail_response(response), flatten, flatten_mode)
}

#' List Interpol red notice images
#'
#' @param notice_id Notice ID.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' Returns images metadata for a red notice.
#' Official docs: https://interpol.api.bund.dev.
#'
#' @examples
#' \dontrun{
#' interpol_red_notice_images("1993-27493")
#' }
#'
#' @return A tibble with image metadata.
#' @export
interpol_red_notice_images <- function(notice_id,
                                       safe = TRUE,
                                       refresh = FALSE,
                                       flatten = FALSE,
                                       flatten_mode = "json") {
  response <- interpol_request(
    path = "/notices/v1/red/{noticeID}/images",
    params = list(noticeID = notice_id),
    safe = safe,
    refresh = refresh
  )

  interpol_maybe_flatten(interpol_tidy_images_response(response), flatten, flatten_mode)
}

#' List Interpol yellow notices
#'
#' @param params Query parameters.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' Returns Interpol yellow notices. Official docs:
#' https://interpol.api.bund.dev.
#'
#' @examples
#' \dontrun{
#' interpol_yellow_notices(params = list(resultPerPage = 10, page = 1))
#' }
#'
#' @return A tibble with notices metadata.
#' @export
interpol_yellow_notices <- function(params = list(),
                                    safe = TRUE,
                                    refresh = FALSE,
                                    flatten = FALSE,
                                    flatten_mode = "json") {
  response <- interpol_request(
    path = "/notices/v1/yellow",
    params = params,
    safe = safe,
    refresh = refresh
  )

  interpol_maybe_flatten(interpol_tidy_list_response(response), flatten, flatten_mode)
}

#' Get an Interpol yellow notice
#'
#' @param notice_id Notice ID.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' Returns detailed data for a yellow notice.
#' Official docs: https://interpol.api.bund.dev.
#'
#' @examples
#' \dontrun{
#' interpol_yellow_notice("2014-5590")
#' }
#'
#' @return A tibble with notice details.
#' @export
interpol_yellow_notice <- function(notice_id,
                                   safe = TRUE,
                                   refresh = FALSE,
                                   flatten = FALSE,
                                   flatten_mode = "json") {
  response <- interpol_request(
    path = "/notices/v1/yellow/{noticeID}",
    params = list(noticeID = notice_id),
    safe = safe,
    refresh = refresh
  )

  interpol_maybe_flatten(interpol_tidy_detail_response(response), flatten, flatten_mode)
}

#' List Interpol yellow notice images
#'
#' @param notice_id Notice ID.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' Returns images metadata for a yellow notice.
#' Official docs: https://interpol.api.bund.dev.
#'
#' @examples
#' \dontrun{
#' interpol_yellow_notice_images("2014-5590")
#' }
#'
#' @return A tibble with image metadata.
#' @export
interpol_yellow_notice_images <- function(notice_id,
                                          safe = TRUE,
                                          refresh = FALSE,
                                          flatten = FALSE,
                                          flatten_mode = "json") {
  response <- interpol_request(
    path = "/notices/v1/yellow/{noticeID}/images",
    params = list(noticeID = notice_id),
    safe = safe,
    refresh = refresh
  )

  interpol_maybe_flatten(interpol_tidy_images_response(response), flatten, flatten_mode)
}

#' List Interpol UN notices
#'
#' @param params Query parameters.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' Returns UN notices from Interpol. Official docs:
#' https://interpol.api.bund.dev.
#'
#' @examples
#' \dontrun{
#' interpol_un_notices(params = list(resultPerPage = 10, page = 1))
#' }
#'
#' @return A tibble with notices metadata.
#' @export
interpol_un_notices <- function(params = list(),
                                safe = TRUE,
                                refresh = FALSE,
                                flatten = FALSE,
                                flatten_mode = "json") {
  response <- interpol_request(
    path = "/notices/v1/un",
    params = params,
    safe = safe,
    refresh = refresh
  )

  interpol_maybe_flatten(interpol_tidy_list_response(response), flatten, flatten_mode)
}

#' Get an Interpol UN notice
#'
#' @param notice_type Notice type: "persons" or "entities".
#' @param notice_id Notice ID.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' Returns detailed data for a UN notice.
#' Official docs: https://interpol.api.bund.dev.
#'
#' @examples
#' \dontrun{
#' interpol_un_notice("persons", "2021-84506")
#' }
#'
#' @return A tibble with notice details.
#' @export
interpol_un_notice <- function(notice_type,
                               notice_id,
                               safe = TRUE,
                               refresh = FALSE,
                               flatten = FALSE,
                               flatten_mode = "json") {
  notice_type <- rlang::arg_match(notice_type, c("persons", "entities"))
  response <- interpol_request(
    path = "/notices/v1/un/{noticeType}/{noticeID}",
    params = list(noticeType = notice_type, noticeID = notice_id),
    safe = safe,
    refresh = refresh
  )

  interpol_maybe_flatten(interpol_tidy_detail_response(response), flatten, flatten_mode)
}

#' List Interpol UN notice images
#'
#' @param notice_type Notice type: "persons" or "entities".
#' @param notice_id Notice ID.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#' @param flatten Logical; drop nested list columns.
#' @param flatten_mode Flatten strategy for list columns. Use "unnest" to
#'   expand list-columns into multiple rows.
#'
#' @details
#' Returns images metadata for a UN notice.
#' Official docs: https://interpol.api.bund.dev.
#'
#' @examples
#' \dontrun{
#' interpol_un_notice_images("persons", "2021-84506")
#' }
#'
#' @return A tibble with image metadata.
#' @export
interpol_un_notice_images <- function(notice_type,
                                      notice_id,
                                      safe = TRUE,
                                      refresh = FALSE,
                                      flatten = FALSE,
                                      flatten_mode = "json") {
  notice_type <- rlang::arg_match(notice_type, c("persons", "entities"))
  response <- interpol_request(
    path = "/notices/v1/un/{noticeType}/{noticeID}/images",
    params = list(noticeType = notice_type, noticeID = notice_id),
    safe = safe,
    refresh = refresh
  )

  interpol_maybe_flatten(interpol_tidy_images_response(response), flatten, flatten_mode)
}

interpol_request <- function(path,
                             params = list(),
                             safe = TRUE,
                             refresh = FALSE,
                             parse = "json") {
  # bunddev_call() now handles path parameters automatically
  bunddev_call(
    "interpol",
    path = path,
    method = "GET",
    params = params,
    parse = parse,
    safe = safe,
    refresh = refresh
  )
}

interpol_tidy_list_response <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  query <- response$query %||% list()
  notices <- response$`_embedded`$notices %||% list()

  tibble::tibble(
    total = response$total %||% NA_integer_,
    page = query$page %||% NA_integer_,
    result_per_page = query$resultPerPage %||% NA_integer_,
    notices = list(notices),
    links = list(response$`_links` %||% list())
  )
}

interpol_tidy_detail_response <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  cleaned <- purrr::map(response, ~ if (is.null(.x)) NA else .x)
  data <- tibble::as_tibble(cleaned)
  interpol_add_time_cols(data)
}

interpol_tidy_images_response <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  images <- response$`_embedded`$images %||% list()
  tibble::tibble(
    images = list(images),
    links = list(response$`_links` %||% list())
  )
}

interpol_add_time_cols <- function(data) {
  time_fields <- c("date_of_birth", "date_of_event", "un_reference_date")
  fields <- intersect(time_fields, names(data))
  if (length(fields) == 0) {
    return(data)
  }

  for (field in fields) {
    data[[paste0(field, "_time")]] <- as.POSIXct(
      as.character(data[[field]]),
      format = "%Y/%m/%d",
      tz = "Europe/Berlin"
    )
  }

  data
}

interpol_maybe_flatten <- function(data, flatten, flatten_mode) {
  if (!isTRUE(flatten)) {
    return(data)
  }

  list_cols <- names(data)[purrr::map_lgl(data, is.list)]
  bunddev_flatten_list_cols(data, cols = list_cols, mode = flatten_mode)
}

bunddev_interpol_red_notices <- function(params = list(),
                                         safe = TRUE,
                                         refresh = FALSE,
                                         flatten = FALSE,
                                         flatten_mode = "json") {
  interpol_red_notices(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_interpol_red_notice <- function(notice_id,
                                        safe = TRUE,
                                        refresh = FALSE,
                                        flatten = FALSE,
                                        flatten_mode = "json") {
  interpol_red_notice(
    notice_id = notice_id,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_interpol_red_notice_images <- function(notice_id,
                                               safe = TRUE,
                                               refresh = FALSE,
                                               flatten = FALSE,
                                               flatten_mode = "json") {
  interpol_red_notice_images(
    notice_id = notice_id,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_interpol_yellow_notices <- function(params = list(),
                                            safe = TRUE,
                                            refresh = FALSE,
                                            flatten = FALSE,
                                            flatten_mode = "json") {
  interpol_yellow_notices(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_interpol_yellow_notice <- function(notice_id,
                                           safe = TRUE,
                                           refresh = FALSE,
                                           flatten = FALSE,
                                           flatten_mode = "json") {
  interpol_yellow_notice(
    notice_id = notice_id,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_interpol_yellow_notice_images <- function(notice_id,
                                                  safe = TRUE,
                                                  refresh = FALSE,
                                                  flatten = FALSE,
                                                  flatten_mode = "json") {
  interpol_yellow_notice_images(
    notice_id = notice_id,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_interpol_un_notices <- function(params = list(),
                                        safe = TRUE,
                                        refresh = FALSE,
                                        flatten = FALSE,
                                        flatten_mode = "json") {
  interpol_un_notices(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_interpol_un_notice <- function(notice_type,
                                       notice_id,
                                       safe = TRUE,
                                       refresh = FALSE,
                                       flatten = FALSE,
                                       flatten_mode = "json") {
  interpol_un_notice(
    notice_type = notice_type,
    notice_id = notice_id,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}

bunddev_interpol_un_notice_images <- function(notice_type,
                                              notice_id,
                                              safe = TRUE,
                                              refresh = FALSE,
                                              flatten = FALSE,
                                              flatten_mode = "json") {
  interpol_un_notice_images(
    notice_type = notice_type,
    notice_id = notice_id,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}
