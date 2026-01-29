#' Read the bundled API registry
#'
#' @return A tibble with registry entries.
#' @export
bunddev_registry <- function() {
  registry_path <- system.file("registry", "registry.yml", package = "bunddev")
  if (registry_path == "") {
    cli::cli_abort("Registry file not found.")
  }

  registry <- yaml::read_yaml(registry_path)
  if (is.null(registry) || !is.list(registry)) {
    cli::cli_abort("Registry file is empty or invalid.")
  }

  required_fields <- c("id", "title", "provider", "spec_url", "docs_url", "auth", "tags")
  missing_fields <- purrr::map_lgl(registry, ~ !all(required_fields %in% names(.x)))
  if (any(missing_fields)) {
    cli::cli_abort("Registry entries must include {required_fields}.")
  }

  ids <- purrr::map_chr(registry, "id")
  if (anyDuplicated(ids)) {
    cli::cli_abort("Registry ids must be unique.")
  }

  auth_values <- c("none", "api_key", "oauth2")
  invalid_auth <- purrr::map_lgl(registry, ~ !.x$auth %in% auth_values)
  if (any(invalid_auth)) {
    cli::cli_abort("Registry auth must be one of: {auth_values}.")
  }

  null_chr <- function(value) {
    if (is.null(value) || identical(value, "")) NA_character_ else as.character(value)
  }

  registry_tbl <- tibble::tibble(
    id = ids,
    title = purrr::map_chr(registry, ~ null_chr(.x$title)),
    provider = purrr::map_chr(registry, ~ null_chr(.x$provider)),
    spec_url = purrr::map_chr(registry, ~ null_chr(.x$spec_url)),
    docs_url = purrr::map_chr(registry, ~ null_chr(.x$docs_url)),
    auth = purrr::map_chr(registry, ~ null_chr(.x$auth)),
    rate_limit = purrr::map_chr(registry, ~ null_chr(.x$rate_limit)),
    tags = purrr::map(registry, "tags")
  )

  dplyr::as_tibble(registry_tbl)
}

#' List registry entries
#'
#' @param tag Optional tag to filter on.
#' @param auth Optional auth type to filter on.
#'
#' @return A tibble of registry entries.
#' @export
bunddev_list <- function(tag = NULL, auth = NULL) {
  registry <- bunddev_registry()

  if (!is.null(tag)) {
    registry <- registry[purrr::map_lgl(registry$tags, ~ tag %in% .x), , drop = FALSE]
  }

  if (!is.null(auth)) {
    registry <- registry[registry$auth == auth, , drop = FALSE]
  }

  registry
}

#' Search registry entries
#'
#' @param q Search query.
#'
#' @return A tibble of matching registry entries.
#' @export
bunddev_search <- function(q) {
  registry <- bunddev_registry()
  query <- stringr::str_to_lower(q)

  tag_text <- purrr::map_chr(registry$tags, ~ paste(.x, collapse = " "))
  search_text <- stringr::str_to_lower(
    paste(registry$id, registry$title, registry$provider, tag_text)
  )

  matches <- stringr::str_detect(search_text, query)
  registry[matches, , drop = FALSE]
}

#' Get a registry entry by id
#'
#' @param id Registry id.
#'
#' @return A tibble with a single registry entry.
#' @export
bunddev_info <- function(id) {
  registry <- bunddev_registry()
  match <- registry[registry$id == id, , drop = FALSE]

  if (nrow(match) == 0) {
    cli::cli_abort("No registry entry found for id '{id}'.")
  }

  match
}
