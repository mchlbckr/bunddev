#' List OpenAPI endpoints for an API
#'
#' @param id Registry id.
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
