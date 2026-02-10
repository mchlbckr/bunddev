#' Get exchange rates for customs calculations
#'
#' @param last_modified_date Optional datetime to retrieve only changes after
#'   this date (format: "YYYY-MM-DD" or "YYYY-MM-DDTHH:MM:SS").
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#'
#' @details
#' The Zoll API provides import tariff and exchange rate data from the German
#' Federal Ministry of Finance. This function returns currency exchange rates
#' used for customs calculations.
#' Official docs: https://zoll.api.bund.dev.
#'
#' @seealso
#' [zoll_produkte()] for product tariffs,
#' [zoll_laender()] for country data.
#'
#' @examples
#' \dontrun{
#' zoll_kurse()
#' }
#'
#' @return A tibble with exchange rate data.
#' @export
zoll_kurse <- function(last_modified_date = NULL,
                       safe = TRUE,
                       refresh = FALSE) {
  params <- list(view = "jsonexportkurseZOLLWeb")
  if (!is.null(last_modified_date)) {
    params$lastModifiedDate <- last_modified_date
  }

  response <- zoll_request(
    "https://zoll.api.proxy.bund.dev/SiteGlobals/Functions/Kurse/App/KursExport.txt",
    params = params,
    safe = safe,
    refresh = refresh,
    parse = "text"
  )

  zoll_tidy_kurse(response)
}

#' Get product tariff data
#'
#' @param last_modified_date Optional datetime to retrieve only changes after
#'   this date.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#'
#' @details
#' Returns product database with import tariff rates.
#'
#' @seealso
#' [zoll_kurse()] for exchange rates,
#' [zoll_produktgruppen()] for product groups.
#'
#' @examples
#' \dontrun{
#' zoll_produkte()
#' }
#'
#' @return A tibble with product tariff data.
#' @export
zoll_produkte <- function(last_modified_date = NULL,
                          safe = TRUE,
                          refresh = FALSE) {
  response <- zoll_request_bmf(
    "/produkte",
    last_modified_date = last_modified_date,
    safe = safe,
    refresh = refresh
  )

  zoll_tidy_data(response)
}

#' Get country data for customs
#'
#' @param last_modified_date Optional datetime to retrieve only changes after
#'   this date.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#'
#' @details
#' Returns country information and classifications for customs purposes.
#'
#' @seealso
#' [zoll_produkte()] for products.
#'
#' @examples
#' \dontrun{
#' zoll_laender()
#' }
#'
#' @return A tibble with country data.
#' @export
zoll_laender <- function(last_modified_date = NULL,
                         safe = TRUE,
                         refresh = FALSE) {
  response <- zoll_request_bmf(
    "/laender",
    last_modified_date = last_modified_date,
    safe = safe,
    refresh = refresh
  )

  zoll_tidy_data(response)
}

#' Get product groups
#'
#' @param last_modified_date Optional datetime to retrieve only changes after
#'   this date.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#'
#' @details
#' Returns product group classifications.
#'
#' @examples
#' \dontrun{
#' zoll_produktgruppen()
#' }
#'
#' @return A tibble with product group data.
#' @export
zoll_produktgruppen <- function(last_modified_date = NULL,
                                safe = TRUE,
                                refresh = FALSE) {
  response <- zoll_request_bmf(
    "/produktgruppen",
    last_modified_date = last_modified_date,
    safe = safe,
    refresh = refresh
  )

  zoll_tidy_data(response)
}

#' Get product categories
#'
#' @param last_modified_date Optional datetime to retrieve only changes after
#'   this date.
#' @param safe Logical; apply throttling and caching.
#' @param refresh Logical; refresh cached responses.
#'
#' @details
#' Returns product category database.
#'
#' @examples
#' \dontrun{
#' zoll_kategorien()
#' }
#'
#' @return A tibble with category data.
#' @export
zoll_kategorien <- function(last_modified_date = NULL,
                            safe = TRUE,
                            refresh = FALSE) {
  response <- zoll_request_bmf(
    "/kategorien",
    last_modified_date = last_modified_date,
    safe = safe,
    refresh = refresh
  )

  zoll_tidy_data(response)
}

zoll_request <- function(url, params = list(), safe = TRUE, refresh = FALSE, parse = "json") {
  # Zoll API uses full URLs, so we pass it as base_url with empty path
  # Custom User-Agent header required for zoll API
  bunddev_call(
    "zoll",
    path = "",
    method = "GET",
    params = params,
    base_url = url,
    headers = list(`User-Agent` = "zollundpost/2 CFNetwork/1220.1 Darwin/20.3.0"),
    parse = parse,
    safe = safe,
    refresh = refresh
  )
}

zoll_request_bmf <- function(path, last_modified_date = NULL, safe = TRUE, refresh = FALSE) {
  base_url <- "https://zoll.api.proxy.bund.dev/SiteGlobals/Functions/Apps/retrieve"
  url <- paste0(base_url, path)

  params <- list(
    client = "ZUP",
    view = "renderJson[App]"
  )
  if (!is.null(last_modified_date)) {
    params$lastModifiedDate <- last_modified_date
  }

  zoll_request(url, params, safe, refresh, parse = "json")
}

zoll_tidy_kurse <- function(response) {
  if (is.null(response) || response == "") {
    return(tibble::tibble())
  }

  lines <- strsplit(response, "\n")[[1]]
  lines <- lines[lines != ""]

  if (length(lines) == 0) {
    return(tibble::tibble())
  }

  # Parse tab-separated or semicolon-separated format
  rows <- purrr::map(lines, function(line) {
    parts <- strsplit(line, "\t|;")[[1]]
    if (length(parts) >= 3) {
      tibble::tibble(
        currency = parts[1],
        rate = as.numeric(gsub(",", ".", parts[2])),
        date = parts[3]
      )
    } else {
      tibble::tibble(raw = line)
    }
  })

  dplyr::bind_rows(rows)
}

zoll_tidy_data <- function(response) {
  if (is.null(response) || length(response) == 0) {
    return(tibble::tibble())
  }

  data <- response$data
  if (is.null(data)) {
    if (is.data.frame(response)) {
      return(tibble::as_tibble(response))
    }
    return(tibble::tibble(response = list(response)))
  }

  # Combine inserted, updated arrays
  items <- c(
    data$inserted %||% list(),
    data$updated %||% list()
  )

  if (length(items) == 0) {
    return(tibble::tibble())
  }

  if (is.data.frame(items)) {
    return(tibble::as_tibble(items))
  }

  rows <- purrr::map(items, function(item) {
    tibble::as_tibble(purrr::map(item, ~ if (is.null(.x)) NA else .x))
  })

  dplyr::bind_rows(rows)
}

bunddev_zoll_kurse <- function(last_modified_date = NULL,
                               safe = TRUE,
                               refresh = FALSE) {
  zoll_kurse(
    last_modified_date = last_modified_date,
    safe = safe,
    refresh = refresh
  )
}

bunddev_zoll_produkte <- function(last_modified_date = NULL,
                                  safe = TRUE,
                                  refresh = FALSE) {
  zoll_produkte(
    last_modified_date = last_modified_date,
    safe = safe,
    refresh = refresh
  )
}

bunddev_zoll_laender <- function(last_modified_date = NULL,
                                 safe = TRUE,
                                 refresh = FALSE) {
  zoll_laender(
    last_modified_date = last_modified_date,
    safe = safe,
    refresh = refresh
  )
}

bunddev_zoll_produktgruppen <- function(last_modified_date = NULL,
                                        safe = TRUE,
                                        refresh = FALSE) {
  zoll_produktgruppen(
    last_modified_date = last_modified_date,
    safe = safe,
    refresh = refresh
  )
}

bunddev_zoll_kategorien <- function(last_modified_date = NULL,
                                    safe = TRUE,
                                    refresh = FALSE) {
  zoll_kategorien(
    last_modified_date = last_modified_date,
    safe = safe,
    refresh = refresh
  )
}
