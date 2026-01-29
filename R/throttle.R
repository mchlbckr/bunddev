#' Set API rate limit configuration
#'
#' @param api Registry id.
#' @param max_per_hour Maximum number of calls per hour.
#'
#' @return The stored rate limit configuration.
#' @export
bunddev_rate_limit_set <- function(api, max_per_hour) {
  if (missing(max_per_hour) || is.null(max_per_hour) || max_per_hour <= 0) {
    cli::cli_abort("max_per_hour must be a positive number.")
  }

  limits <- getOption("bunddev.rate_limit", list())
  limits[[api]] <- list(
    max_per_hour = as.integer(max_per_hour),
    timestamps = numeric()
  )
  options(bunddev.rate_limit = limits)
  limits[[api]]
}

#' Get API rate limit configuration
#'
#' @param api Registry id.
#'
#' @return The rate limit configuration.
#' @export
bunddev_rate_limit_get <- function(api) {
  limits <- getOption("bunddev.rate_limit", list())
  entry <- limits[[api]]

  if (is.null(entry)) {
    return(list(max_per_hour = NA_integer_, timestamps = numeric()))
  }

  entry
}

bunddev_rate_limit_wait <- function(api) {
  entry <- bunddev_rate_limit_get(api)
  if (is.na(entry$max_per_hour)) {
    return(invisible(NULL))
  }

  now <- as.numeric(Sys.time())
  window <- 3600
  timestamps <- entry$timestamps
  if (length(timestamps) > 0) {
    timestamps <- timestamps[timestamps > (now - window)]
  }

  if (length(timestamps) >= entry$max_per_hour) {
    wait_for <- window - (now - min(timestamps))
    if (wait_for > 0) {
      Sys.sleep(wait_for)
      now <- as.numeric(Sys.time())
    }
  }

  timestamps <- c(timestamps, now)
  limits <- getOption("bunddev.rate_limit", list())
  limits[[api]] <- list(max_per_hour = entry$max_per_hour, timestamps = timestamps)
  options(bunddev.rate_limit = limits)
  invisible(NULL)
}
