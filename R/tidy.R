#' Call an API operation and return tidy data
#'
#' @param api Registry id.
#' @param operation_id OpenAPI operationId.
#' @param params List of parameters.
#' @param ... Additional arguments passed to the tidier.
#'
#' @return A tibble with tidied results.
#' @export
bunddev_call_tidy <- function(api, operation_id, params = list(), ...) {
  response <- bunddev_call(api, operation_id, params = params, parse = "json")
  tidier <- bunddev_tidy_dispatch(api)

  if (is.null(tidier)) {
    return(tibble::tibble(raw = list(response)))
  }

  tidier(response, operation_id = operation_id, ...)
}

bunddev_tidy_dispatch <- function(api) {
  if (api == "bewerberboerse") {
    return(bunddev_tidy_bewerberboerse)
  }
  if (api == "autobahn") {
    return(bunddev_tidy_autobahn)
  }
  NULL
}
