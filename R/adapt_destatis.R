#' List Destatis tables
#'
#' @param params Named list of Genesis API query parameters. Common keys:
#'   \describe{
#'     \item{username}{Genesis username (added automatically from `username` if missing).}
#'     \item{password}{Genesis password (added automatically from `password` if missing).}
#'     \item{name}{Table/cube name for data endpoints (also set by `name` argument).}
#'     \item{selection}{Selection filter expression (character).}
#'     \item{area}{Regional scope code (character).}
#'     \item{pagelength}{Maximum number of returned entries (integer).}
#'     \item{language}{Response language code (character).}
#'     \item{searchcriterion}{Catalogue search field (character).}
#'     \item{sortcriterion}{Catalogue sort field (character).}
#'     \item{type}{Resource type filter (character).}
#'     \item{startyear}{Start year filter (integer).}
#'     \item{endyear}{End year filter (integer).}
#'   }
#' @param username Genesis username (default "GAST").
#' @param password Genesis password (default "GAST").
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns the table catalogue from the Destatis Genesis API.
#' API documentation: \url{https://github.com/bundesAPI/destatis-api}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' destatis_catalogue_tables()
#' }
#'
#' @return A one-row tibble with one list-column `response` containing the
#' parsed catalogue payload.
#' Top-level scalar API fields are returned as tibble columns; nested
#' objects or arrays are kept in list-columns unless the function provides
#' `flatten` / `flatten_mode` controls.
#' @family Destatis
#' @export
destatis_catalogue_tables <- function(params = list(),
                                      username = "GAST",
                                      password = "GAST",
                                      safe = TRUE,
                                      refresh = FALSE) {
  params <- destatis_add_auth_params(params, username, password)
  response <- destatis_request(
    "/catalogue/tables",
    params = params,
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  destatis_tidy_response(response)
}

#' List Destatis cubes
#'
#' @inheritParams destatis_catalogue_tables
#' @param username Genesis username (default "GAST").
#' @param password Genesis password (default "GAST").
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns the cube catalogue from the Destatis Genesis API.
#' API documentation: \url{https://github.com/bundesAPI/destatis-api}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' destatis_catalogue_cubes()
#' }
#'
#' @return A one-row tibble with one list-column `response` containing the
#' parsed catalogue payload.
#' Top-level scalar API fields are returned as tibble columns; nested
#' objects or arrays are kept in list-columns unless the function provides
#' `flatten` / `flatten_mode` controls.
#' @family Destatis
#' @export
destatis_catalogue_cubes <- function(params = list(),
                                     username = "GAST",
                                     password = "GAST",
                                     safe = TRUE,
                                     refresh = FALSE) {
  params <- destatis_add_auth_params(params, username, password)
  response <- destatis_request(
    "/catalogue/cubes",
    params = params,
    parse = "json",
    safe = safe,
    refresh = refresh
  )

  destatis_tidy_response(response)
}

#' Retrieve Destatis table data
#'
#' @param name Table id.
#' @inheritParams destatis_catalogue_tables
#' @param username Genesis username (default "GAST").
#' @param password Genesis password (default "GAST").
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns table data as text (csv by default).
#' API documentation: \url{https://github.com/bundesAPI/destatis-api}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' destatis_data_table("12411-0001")
#' }
#'
#' @return A one-row tibble with:
#' \describe{
#'   \item{name}{Requested table id (character).}
#'   \item{data}{Raw response body (typically CSV/text) (character).}
#' }
#' @family Destatis
#' @export
destatis_data_table <- function(name,
                                params = list(),
                                username = "GAST",
                                password = "GAST",
                                safe = TRUE,
                                refresh = FALSE) {
  params <- destatis_add_auth_params(params, username, password)
  params$name <- name
  response <- destatis_request(
    "/data/table",
    params = params,
    parse = "text",
    safe = safe,
    refresh = refresh
  )

  tibble::tibble(name = name, data = response)
}

#' Retrieve Destatis cube data
#'
#' @param name Cube id.
#' @inheritParams destatis_catalogue_tables
#' @param username Genesis username (default "GAST").
#' @param password Genesis password (default "GAST").
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns cube data as text (csv by default).
#' API documentation: \url{https://github.com/bundesAPI/destatis-api}.
#'
#' @seealso
#' [bunddev_parameters()] to inspect available query parameters.
#' @examples
#' \dontrun{
#' destatis_data_cube("21231BJ001")
#' }
#'
#' @return A one-row tibble with:
#' \describe{
#'   \item{name}{Requested cube id (character).}
#'   \item{data}{Raw response body (typically CSV/text) (character).}
#' }
#' @family Destatis
#' @export
destatis_data_cube <- function(name,
                               params = list(),
                               username = "GAST",
                               password = "GAST",
                               safe = TRUE,
                               refresh = FALSE) {
  params <- destatis_add_auth_params(params, username, password)
  params$name <- name
  response <- destatis_request(
    "/data/cube",
    params = params,
    parse = "text",
    safe = safe,
    refresh = refresh
  )

  tibble::tibble(name = name, data = response)
}

destatis_add_auth_params <- function(params, username, password) {
  if (!"username" %in% names(params)) {
    params$username <- username
  }
  if (!"password" %in% names(params)) {
    params$password <- password
  }
  params
}

destatis_request <- function(path,
                             params = list(),
                             safe = TRUE,
                             refresh = FALSE,
                             parse = "json") {
  # Always get raw text first, since destatis sometimes returns HTML error pages
  response_text <- bunddev_call(
    "destatis",
    path = path,
    method = "GET",
    params = params,
    parse = "text",
    safe = safe,
    refresh = refresh
  )

  # Apply custom parsing with fallback for non-JSON responses
  if (parse == "json") {
    trimmed <- trimws(response_text)
    if (trimmed != "" && grepl("^[\\[{]", trimmed)) {
      parsed <- tryCatch(
        jsonlite::fromJSON(response_text, simplifyVector = FALSE),
        error = function(e) NULL
      )
      if (!is.null(parsed)) {
        return(parsed)
      }
    }
    # Return text if not valid JSON (e.g., HTML error page)
    return(response_text)
  }

  response_text
}

destatis_base_url <- function(spec) {
  scheme <- "https"
  if (!is.null(spec$schemes) && length(spec$schemes) > 0) {
    scheme <- spec$schemes[[1]]
  }
  host <- spec$host %||% "www-genesis.destatis.de"
  base_path <- spec$basePath %||% "/genesisWS/rest/2020/"
  base_path <- stringr::str_replace(base_path, "/*$", "/")
  paste0(scheme, "://", host, base_path)
}

destatis_parse_response <- function(raw_body, parse) {
  if (parse == "json") {
    text <- rawToChar(raw_body)
    trimmed <- trimws(text)
    if (trimmed != "" && grepl("^[\\[{]", trimmed)) {
      parsed <- tryCatch(
        jsonlite::fromJSON(text, simplifyVector = FALSE),
        error = function(e) NULL
      )
      if (!is.null(parsed)) {
        return(parsed)
      }
    }
    return(text)
  }

  if (parse == "text") {
    return(rawToChar(raw_body))
  }

  raw_body
}

destatis_tidy_response <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  tibble::tibble(response = list(response))
}

bunddev_destatis_catalogue_tables <- function(params = list(),
                                              username = "GAST",
                                              password = "GAST",
                                              safe = TRUE,
                                              refresh = FALSE) {
  destatis_catalogue_tables(
    params = params,
    username = username,
    password = password,
    safe = safe,
    refresh = refresh
  )
}

bunddev_destatis_catalogue_cubes <- function(params = list(),
                                             username = "GAST",
                                             password = "GAST",
                                             safe = TRUE,
                                             refresh = FALSE) {
  destatis_catalogue_cubes(
    params = params,
    username = username,
    password = password,
    safe = safe,
    refresh = refresh
  )
}

bunddev_destatis_data_table <- function(name,
                                        params = list(),
                                        username = "GAST",
                                        password = "GAST",
                                        safe = TRUE,
                                        refresh = FALSE) {
  destatis_data_table(
    name = name,
    params = params,
    username = username,
    password = password,
    safe = safe,
    refresh = refresh
  )
}

bunddev_destatis_data_cube <- function(name,
                                       params = list(),
                                       username = "GAST",
                                       password = "GAST",
                                       safe = TRUE,
                                       refresh = FALSE) {
  destatis_data_cube(
    name = name,
    params = params,
    username = username,
    password = password,
    safe = safe,
    refresh = refresh
  )
}
