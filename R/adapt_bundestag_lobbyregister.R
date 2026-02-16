#' Search the Bundestag lobbyregister
#'
#' @param q Optional search string.
#' @param sort Optional sorting order.
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
#' Returns search results from the Bundestag lobbyregister.
#' API documentation: \url{https://bundesapi.github.io/bundestag-lobbyregister-api/}.
#'
#' @examples
#' \dontrun{
#' bundestag_lobbyregister_search(q = "energie")
#' }
#'
#' @return A one-row tibble with search metadata:
#' \describe{
#'   \item{source}{Source label from the API payload (character).}
#'   \item{source_url}{Source URL (character).}
#'   \item{search_url}{URL of the executed search (character).}
#'   \item{search_date}{Search timestamp/date string (character).}
#'   \item{search_parameters}{Effective search parameter object (list-column).}
#'   \item{result_count}{Total result count (integer).}
#'   \item{results}{Search result entries (list-column).}
#' }
#' @family Bundestag Lobbyregister
#' @export
bundestag_lobbyregister_search <- function(q = NULL,
                                           sort = NULL,
                                           safe = TRUE,
                                           refresh = FALSE,
                                           flatten = FALSE,
                                           flatten_mode = "json") {
  params <- list()
  if (!is.null(q)) {
    params$q <- q
  }
  if (!is.null(sort)) {
    params$sort <- sort
  }

  response <- bunddev_call(
    "bundestag_lobbyregister",
    "sucheDetailJson",
    params = params,
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  data <- bundestag_lobbyregister_tidy(response)
  if (flatten) {
    return(bunddev_flatten_list_cols(
      data,
      cols = c("search_parameters", "results", "source"),
      mode = flatten_mode
    ))
  }

  data
}

bundestag_lobbyregister_tidy <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  tibble::tibble(
    source = response$source %||% NA_character_,
    source_url = response$sourceUrl %||% NA_character_,
    search_url = response$searchUrl %||% NA_character_,
    search_date = response$searchDate %||% NA_character_,
    search_parameters = list(response$searchParameters %||% list()),
    result_count = response$resultCount %||% NA_integer_,
    results = list(response$results %||% list())
  )
}

bunddev_bundestag_lobbyregister_search <- function(q = NULL,
                                                   sort = NULL,
                                                   safe = TRUE,
                                                   refresh = FALSE,
                                                   flatten = FALSE,
                                                   flatten_mode = "json") {
  bundestag_lobbyregister_search(
    q = q,
    sort = sort,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}
