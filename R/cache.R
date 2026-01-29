#' Locate the bunddev cache directory
#'
#' @return Cache directory path.
#' @export
bunddev_cache_dir <- function() {
  cache_dir <- tools::R_user_dir("bunddev", "cache")
  if (!dir.exists(cache_dir)) {
    dir.create(cache_dir, recursive = TRUE, showWarnings = FALSE)
  }
  cache_dir
}

#' Build a cache path for an API spec
#'
#' @param id Registry id.
#'
#' @return File path for the cached spec.
#' @export
bunddev_spec_path <- function(id) {
  info <- bunddev_info(id)
  spec_url <- info$spec_url[[1]]
  url_path <- httr2::url_parse(spec_url)$path
  ext <- tools::file_ext(url_path)
  if (identical(ext, "")) {
    ext <- "json"
  }
  file.path(bunddev_cache_dir(), paste0(id, ".", ext))
}

#' Retrieve a cached API spec
#'
#' @param id Registry id.
#' @param refresh Logical; refresh cached spec.
#'
#' @return Parsed OpenAPI spec.
#' @export
bunddev_spec <- function(id, refresh = FALSE) {
  info <- bunddev_info(id)
  spec_url <- info$spec_url[[1]]
  spec_path <- bunddev_spec_path(id)

  if (refresh || !file.exists(spec_path)) {
    request <- httr2::request(spec_url)
    response <- httr2::req_perform(request)
    raw_body <- httr2::resp_body_raw(response)
    writeBin(raw_body, spec_path)
  }

  ext <- tools::file_ext(spec_path)
  if (ext %in% c("yaml", "yml")) {
    return(yaml::read_yaml(spec_path))
  }
  if (ext == "json") {
    return(jsonlite::fromJSON(spec_path, simplifyVector = FALSE))
  }

  cli::cli_abort("Unsupported spec file extension '{ext}'.")
}
