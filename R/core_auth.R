#' Set authentication configuration for an API
#'
#' @param api Registry id.
#' @param type Authentication type.
#' @param env_var Environment variable containing credentials.
#'
#' @return The updated auth configuration.
#' @export
bunddev_auth_set <- function(api, type = "api_key", env_var) {
  type <- rlang::arg_match(type, c("none", "api_key", "oauth2"))

  if (type == "api_key" && (missing(env_var) || is.null(env_var) || env_var == "")) {
    cli::cli_abort("env_var is required for auth type '{type}'.")
  }

  auth <- getOption("bunddev.auth", list())
  env_value <- if (missing(env_var) || is.null(env_var)) NA_character_ else env_var
  auth[[api]] <- list(type = type, env_var = env_value)
  options(bunddev.auth = auth)
  auth[[api]]
}

#' Get authentication configuration for an API
#'
#' @param api Registry id.
#'
#' @return A list with auth settings.
#' @export
bunddev_auth_get <- function(api) {
  auth <- getOption("bunddev.auth", list())
  if (!is.list(auth) || is.null(auth[[api]])) {
    return(list(type = "none", env_var = NA_character_))
  }

  auth[[api]]
}
