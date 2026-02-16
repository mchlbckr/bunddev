#' Query Bundeshaushalt budget data
#'
#' @param params Named list of query parameters:
#'   \describe{
#'     \item{year}{Budget year (integer, required).}
#'     \item{account}{Account type (`"income"` or `"expenses"`, required).}
#'     \item{quota}{Target value mode, e.g. planned/actual values (character).}
#'     \item{unit}{Budget unit/granularity level (character).}
#'     \item{id}{Optional budget node id to drill into a specific subtree (character).}
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
#' The Bundeshaushalt API provides budget data for federal income and expenses.
#' Required query parameters are `year` and `account`. API documentation: \url{https://github.com/bundesAPI/bundeshaushalt-api}.
#'
#' @examples
#' \dontrun{
#' bundeshaushalt_budget_data(params = list(year = 2021, account = "expenses"))
#' }
#'
#' @return A one-row tibble with budget metadata and nested payloads:
#' \describe{
#'   \item{account}{Requested account type (character).}
#'   \item{entity}{Entity label from the API response (character).}
#'   \item{level_cur}{Current hierarchy level (integer).}
#'   \item{level_max}{Maximum hierarchy level (integer).}
#'   \item{modify_date}{Upstream modification date (character).}
#'   \item{quota}{Quota/target mode (character).}
#'   \item{timestamp}{Response timestamp in milliseconds (numeric).}
#'   \item{timestamp_time}{Response timestamp as `POSIXct` in Europe/Berlin.}
#'   \item{unit}{Selected unit/granularity (character).}
#'   \item{year}{Budget year (integer).}
#'   \item{details}{Detailed budget rows (list-column).}
#'   \item{children}{Child nodes in the budget hierarchy (list-column).}
#'   \item{parents}{Parent nodes in the hierarchy (list-column).}
#'   \item{related}{Related nodes from the API response (list-column).}
#' }
#'
#' @seealso
#' [bunddev_parameters()] to inspect parameter metadata from the OpenAPI spec.
#' @family Bundeshaushalt
#' @export
bundeshaushalt_budget_data <- function(params = list(),
                                       safe = TRUE,
                                       refresh = FALSE,
                                       flatten = FALSE,
                                       flatten_mode = "json") {
  required <- c("year", "account")
  missing <- setdiff(required, names(params))
  if (length(missing) > 0) {
    cli::cli_abort("Missing required parameter(s): {paste(missing, collapse = ", ")}")
  }

  response <- bunddev_call(
    "bundeshaushalt",
    "budgetData",
    params = params,
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  data <- bundeshaushalt_tidy_budget_data(response)
  if (flatten) {
    return(bunddev_flatten_list_cols(
      data,
      cols = c("details", "children", "parents", "related"),
      mode = flatten_mode
    ))
  }

  data
}

bundeshaushalt_tidy_budget_data <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  meta <- response$meta %||% list()
  timestamp <- meta$timestamp %||% NA_real_
  timestamp <- as.numeric(timestamp)

  tibble::tibble(
    account = meta$account %||% NA_character_,
    entity = meta$entity %||% NA_character_,
    level_cur = meta$levelCur %||% NA_integer_,
    level_max = meta$levelMax %||% NA_integer_,
    modify_date = meta$modifyDate %||% NA_character_,
    quota = meta$quota %||% NA_character_,
    timestamp = timestamp,
    timestamp_time = bunddev_ms_to_posix(timestamp),
    unit = meta$unit %||% NA_character_,
    year = meta$year %||% NA_integer_,
    details = list(response$details %||% list()),
    children = list(response$children %||% list()),
    parents = list(response$parents %||% list()),
    related = list(response$related %||% list())
  )
}

bunddev_bundeshaushalt_budget_data <- function(params = list(),
                                               safe = TRUE,
                                               refresh = FALSE,
                                               flatten = FALSE,
                                               flatten_mode = "json") {
  bundeshaushalt_budget_data(
    params = params,
    safe = safe,
    refresh = refresh,
    flatten = flatten,
    flatten_mode = flatten_mode
  )
}
