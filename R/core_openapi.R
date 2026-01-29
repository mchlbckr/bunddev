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

#' List OpenAPI parameters for an API
#'
#' @param id Registry id.
#'
#' @return A tibble with parameter metadata.
#' @export
bunddev_parameters <- function(id) {
  spec <- bunddev_spec(id)
  paths <- spec$paths

  if (is.null(paths) || length(paths) == 0) {
    cli::cli_abort("OpenAPI spec has no paths.")
  }

  params <- purrr::imap_dfr(paths, function(path_item, path) {
    if (!is.list(path_item)) {
      return(tibble::tibble())
    }

    path_params <- path_item$parameters %||% list()
    methods <- setdiff(names(path_item), "parameters")

    purrr::map_dfr(methods, function(method) {
      operation <- path_item[[method]]
      op_params <- operation$parameters %||% list()
      combined <- c(path_params, op_params)

      if (length(combined) == 0) {
        return(tibble::tibble())
      }

      purrr::map_dfr(combined, function(param) {
        resolved <- bunddev_resolve_parameter(param, spec)
        if (is.null(resolved)) {
          return(tibble::tibble())
        }

        schema <- resolved$schema %||% list()
        tibble::tibble(
          method = method,
          path = path,
          name = resolved$name %||% NA_character_,
          location = resolved$`in` %||% NA_character_,
          required = isTRUE(resolved$required),
          description = resolved$description %||% NA_character_,
          schema_type = schema$type %||% NA_character_,
          enum = list(schema$enum %||% character())
        )
      })
    })
  })

  if (nrow(params) == 0) {
    cli::cli_abort("No parameters found in the OpenAPI spec.")
  }

  params
}

bunddev_resolve_parameter <- function(param, spec) {
  if (is.null(param)) {
    return(NULL)
  }
  ref <- param$`$ref`
  if (!is.null(ref)) {
    name <- stringr::str_replace(ref, "^#/components/parameters/", "")
    if (!is.null(spec$components$parameters[[name]])) {
      return(spec$components$parameters[[name]])
    }
    return(NULL)
  }
  param
}
