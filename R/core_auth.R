#' Set authentication configuration for an API
#'
#' @param api Registry id.
#' @param type Authentication type.
#' @param env_var Environment variable containing credentials.
#' @param scheme Authentication scheme used in the Authorization header (e.g., "Bearer", "ApiKey", "OAuth").
#'
#' @details
#' Store auth configuration used by [bunddev_call()] and adapter helpers. For
#' APIs that require an API key, set `env_var` to the name of an environment
#' variable containing the key. The key is sent as an `Authorization: {scheme} <key>`.
#'
#' @seealso
#' [bunddev_auth_get()] to inspect the stored configuration, and
#' [bunddev_call()] to make authenticated requests.
#'
#' @examples
#' 
#' Sys.setenv(JOBBOERSE_API_KEY = "jobboerse-jobsuche")
#' bunddev_auth_set("jobsuche", type = "api_key", env_var = "JOBBOERSE_API_KEY", scheme = "X-API-Key")
#'
#' @return The updated auth configuration.
#' @export
bunddev_auth_set <- function(api, type = "api_key", env_var, scheme = NULL) {
  type <- rlang::arg_match(type, c("none", "api_key", "oauth2"))

  if (type == "api_key" && (missing(env_var) || is.null(env_var) || env_var == "")) {
    cli::cli_abort("env_var is required for auth type '{type}'.")
  }

  auth <- getOption("bunddev.auth", list())
  env_value <- if (missing(env_var) || is.null(env_var)) NA_character_ else env_var
  auth[[api]] <- list(type = type, env_var = env_value, scheme = scheme)
  options(bunddev.auth = auth)
  auth[[api]]
}

#' Get authentication configuration for an API
#'
#' @param api Registry id.
#'
#' @details
#' Returns the stored auth configuration for the API or a default `none` entry
#' if no auth has been configured.
#'
#' @seealso
#' [bunddev_auth_set()] to configure credentials.
#'
#' @examples
#' bunddev_auth_get("jobsuche")
#'
#' @return A list with auth settings.
#' @export
bunddev_auth_get <- function(api) {
  auth <- getOption("bunddev.auth", list())
  if (!is.list(auth) || is.null(auth[[api]])) {
    return(list(type = "none", env_var = NA_character_, scheme = NA_character_))
  }

  auth[[api]]
}

#' Build Authorization header value
#'
#' @param api Registry id.
#' @param token Optional token to use instead of env_var lookup.
#'
#' @details
#' Constructs the Authorization header value based on the configured scheme.
#' Supports template-style schemes containing `%s` for the key/token.
#'
#' @return A character string for the Authorization header, or NULL if no auth.
#' @keywords internal
bunddev_auth_header <- function(api, token = NULL) {

  auth <- bunddev_auth_get(api)
  if (auth$type == "none") {
    return(NULL)
  }

  if (is.null(token)) {
    if (is.na(auth$env_var) || auth$env_var == "") {
      cli::cli_abort("API key env_var is not set for '{api}'.")
    }
    token <- Sys.getenv(auth$env_var)
    if (token == "") {
      cli::cli_abort("Environment variable '{auth$env_var}' is not set.")
    }
  }

  scheme <- if (!is.null(auth$scheme) && !is.na(auth$scheme) && auth$scheme != "") {
    auth$scheme
  } else {
    "X-API-Key"
  }

  # Support template-style schemes (e.g., 'OAuth oauth_consumer_key="%s"')
  if (grepl("%s", scheme, fixed = TRUE)) {
    sprintf(scheme, token)
  } else {
    paste0(scheme, " ", token)
  }
}
