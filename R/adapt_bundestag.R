#' Get a Bundestag news article
#'
#' @param article_id Article id.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns a single Bundestag news article in XML format.
#' API documentation: \url{https://bundesapi.github.io/bundestag-api/}.
#'
#' @examples
#' \dontrun{
#' bundestag_article(849630)
#' }
#'
#' @return A one-row tibble with fields extracted from the XML document. Column
#' names correspond to XML element names.
#' \describe{
#'   \item{`<tag>`}{One column per unique scalar child element of the XML root
#'     (character). Exact names depend on the XML document structure.}
#'   \item{`<repeated_tag>`}{List-column when a child element name appears more
#'     than once.}
#' }
#' @family Bundestag
#' @export
bundestag_article <- function(article_id, safe = TRUE, refresh = FALSE) {
  response <- bundestag_request(
    "/blueprint/servlet/content/{ARTICLE_ID}/asAppV2NewsarticleXml",
    params = list(ARTICLE_ID = article_id),
    safe = safe,
    refresh = refresh
  )

  bundestag_tidy_document(response)
}

#' Get the current Bundestag speaker
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns the current speaker from the plenum feed.
#' API documentation: \url{https://bundesapi.github.io/bundestag-api/}.
#'
#' @examples
#' \dontrun{
#' bundestag_speaker()
#' }
#'
#' @return A one-row tibble with fields extracted from the XML document (same
#' structure rules as [bundestag_article()]).
#' \describe{
#'   \item{`<tag>`}{One column per unique scalar child element of the XML root
#'     (character). Exact names depend on the XML document structure.}
#'   \item{`<repeated_tag>`}{List-column when a child element name appears more
#'     than once.}
#' }
#' @family Bundestag
#' @export
bundestag_speaker <- function(safe = TRUE, refresh = FALSE) {
  response <- bundestag_request(
    "/static/appdata/plenum/v2/speaker.xml",
    safe = safe,
    refresh = refresh
  )

  bundestag_tidy_document(response)
}

#' Get Bundestag conferences overview
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns conference overview data from the plenum feed.
#' API documentation: \url{https://bundesapi.github.io/bundestag-api/}.
#'
#' @examples
#' \dontrun{
#' bundestag_conferences()
#' }
#'
#' @return A tibble with one row per `<item>` entry from the conferences feed.
#' Column names correspond to XML child element names within each `<item>`.
#' \describe{
#'   \item{`<tag>`}{One column per unique scalar child element in each
#'     `<item>` (character). Exact names depend on the feed structure.}
#'   \item{`<repeated_tag>`}{List-column when a child element name appears more
#'     than once in a single `<item>`.}
#' }
#' @family Bundestag
#' @export
bundestag_conferences <- function(safe = TRUE, refresh = FALSE) {
  response <- bundestag_request(
    "/static/appdata/plenum/v2/conferences.xml",
    safe = safe,
    refresh = refresh
  )

  bundestag_tidy_items(response)
}

#' List Bundestag committees
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns the committee index from Bundestag XML feeds.
#' API documentation: \url{https://bundesapi.github.io/bundestag-api/}.
#'
#' @examples
#' \dontrun{
#' bundestag_ausschuesse()
#' }
#'
#' @return A tibble with one row per committee `<item>` from the index feed.
#' Column names correspond to XML child element names within each `<item>`.
#' \describe{
#'   \item{`<tag>`}{One column per unique scalar child element in each
#'     `<item>` (character). Exact names depend on the feed structure.}
#'   \item{`<repeated_tag>`}{List-column when a child element name appears more
#'     than once in a single `<item>`.}
#' }
#' @family Bundestag
#' @export
bundestag_ausschuesse <- function(safe = TRUE, refresh = FALSE) {
  response <- bundestag_request(
    "/xml/v2/ausschuesse/index.xml",
    safe = safe,
    refresh = refresh
  )

  bundestag_tidy_items(response)
}

#' Get Bundestag committee details
#'
#' @param ausschuss_id Committee id (e.g. "a11").
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns details for a single committee.
#' API documentation: \url{https://bundesapi.github.io/bundestag-api/}.
#'
#' @examples
#' \dontrun{
#' bundestag_ausschuss("a11")
#' }
#'
#' @return A one-row tibble with committee detail fields extracted from XML.
#' Column names correspond to XML element names.
#' \describe{
#'   \item{`<tag>`}{One column per unique scalar child element of the XML root
#'     (character). Exact names depend on the XML document structure.}
#'   \item{`<repeated_tag>`}{List-column when a child element name appears more
#'     than once.}
#' }
#' @family Bundestag
#' @export
bundestag_ausschuss <- function(ausschuss_id, safe = TRUE, refresh = FALSE) {
  response <- bundestag_request(
    "/xml/v2/ausschuesse/{AUSSCHUSS_ID}.xml",
    params = list(AUSSCHUSS_ID = ausschuss_id),
    safe = safe,
    refresh = refresh
  )

  bundestag_tidy_document(response)
}

#' List Bundestag members of parliament
#'
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns the index of members of parliament.
#' API documentation: \url{https://bundesapi.github.io/bundestag-api/}.
#'
#' @examples
#' \dontrun{
#' bundestag_mdb_index()
#' }
#'
#' @return A tibble with one row per member `<item>` from the index feed.
#' Column names correspond to XML child element names within each `<item>`.
#' \describe{
#'   \item{`<tag>`}{One column per unique scalar child element in each
#'     `<item>` (character). Exact names depend on the feed structure.}
#'   \item{`<repeated_tag>`}{List-column when a child element name appears more
#'     than once in a single `<item>`.}
#' }
#' @family Bundestag
#' @export
bundestag_mdb_index <- function(safe = TRUE, refresh = FALSE) {
  response <- bundestag_request(
    "/xml/v2/mdb/index.xml",
    safe = safe,
    refresh = refresh
  )

  bundestag_tidy_items(response)
}

#' Get a Bundestag biography
#'
#' @param mdb_id Member id.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns details for a single member of parliament.
#' API documentation: \url{https://bundesapi.github.io/bundestag-api/}.
#'
#' @examples
#' \dontrun{
#' bundestag_mdb_bio(1769)
#' }
#'
#' @return A one-row tibble with biography fields extracted from XML. Column
#' names correspond to XML element names.
#' \describe{
#'   \item{`<tag>`}{One column per unique scalar child element of the XML root
#'     (character). Exact names depend on the XML document structure.}
#'   \item{`<repeated_tag>`}{List-column when a child element name appears more
#'     than once.}
#' }
#' @family Bundestag
#' @export
bundestag_mdb_bio <- function(mdb_id, safe = TRUE, refresh = FALSE) {
  response <- bundestag_request(
    "/xml/v2/mdb/biografien/{MDB_ID}.xml",
    params = list(MDB_ID = mdb_id),
    safe = safe,
    refresh = refresh
  )

  bundestag_tidy_document(response)
}

#' Get a Bundestag video feed entry
#'
#' @param content_id Video content id.
#' @param safe Logical; if `TRUE` (default), apply rate-limiting and cache
#'   GET responses to `tools::R_user_dir("bunddev", "cache")`.
#' @param refresh Logical; if `TRUE`, ignore cached responses and re-fetch
#'   from the API (default `FALSE`).
#'
#' @details
#' Returns a video feed entry from the Bundestag webtv service.
#' API documentation: \url{https://bundesapi.github.io/bundestag-api/}.
#'
#' @examples
#' \dontrun{
#' bundestag_video_feed(7529016)
#' }
#'
#' @return A one-row tibble with video feed fields extracted from XML. Column
#' names correspond to XML element names.
#' \describe{
#'   \item{`<tag>`}{One column per unique scalar child element of the XML root
#'     (character). Exact names depend on the XML document structure.}
#'   \item{`<repeated_tag>`}{List-column when a child element name appears more
#'     than once.}
#' }
#' @family Bundestag
#' @export
bundestag_video_feed <- function(content_id, safe = TRUE, refresh = FALSE) {
  response <- bundestag_request(
    "/iptv/player/macros/_x_s-144277506/bttv/mobile/feed_vod.xml",
    params = list(contentId = content_id),
    base_url = "http://webtv.bundestag.de",
    safe = safe,
    refresh = refresh
  )

  bundestag_tidy_document(response)
}

bundestag_request <- function(path,
                               params = list(),
                               base_url = NULL,
                               safe = TRUE,
                               refresh = FALSE,
                               parse = "xml") {
  bunddev_call(
    "bundestag",
    path = path,
    method = "GET",
    params = params,
    base_url = base_url,
    parse = parse,
    safe = safe,
    refresh = refresh
  )
}

bundestag_tidy_items <- function(document) {
  if (is.null(document)) {
    return(tibble::tibble())
  }

  root <- xml2::xml_root(document)
  items <- xml2::xml_find_all(root, ".//item")
  if (length(items) == 0) {
    return(bundestag_tidy_document(document))
  }

  purrr::map_dfr(items, bundestag_item_to_row)
}

bundestag_tidy_document <- function(document) {
  if (is.null(document)) {
    return(tibble::tibble())
  }

  root <- xml2::xml_root(document)
  children <- xml2::xml_children(root)
  if (length(children) == 0) {
    return(tibble::tibble(root = xml2::xml_name(root), xml = xml2::xml_text(root)))
  }

  child_names <- xml2::xml_name(children)
  values <- purrr::map(unique(child_names), function(name) {
    nodes <- children[child_names == name]
    texts <- xml2::xml_text(nodes, trim = TRUE)
    if (length(texts) == 1) {
      text <- texts[[1]]
      if (is.null(text) || text == "") {
        return(NA_character_)
      }
      return(text)
    }
    list(texts)
  })

  names(values) <- unique(child_names)
  tibble::as_tibble(values)
}

bundestag_item_to_row <- function(item) {
  children <- xml2::xml_children(item)
  if (length(children) == 0) {
    return(tibble::tibble())
  }

  child_names <- xml2::xml_name(children)
  values <- purrr::map(unique(child_names), function(name) {
    nodes <- children[child_names == name]
    texts <- xml2::xml_text(nodes, trim = TRUE)
    if (length(texts) == 1) {
      text <- texts[[1]]
      if (is.null(text) || text == "") {
        return(NA_character_)
      }
      return(text)
    }
    list(texts)
  })

  names(values) <- unique(child_names)
  tibble::as_tibble(values)
}

bunddev_bundestag_article <- function(article_id, safe = TRUE, refresh = FALSE) {
  bundestag_article(article_id = article_id, safe = safe, refresh = refresh)
}

bunddev_bundestag_speaker <- function(safe = TRUE, refresh = FALSE) {
  bundestag_speaker(safe = safe, refresh = refresh)
}

bunddev_bundestag_conferences <- function(safe = TRUE, refresh = FALSE) {
  bundestag_conferences(safe = safe, refresh = refresh)
}

bunddev_bundestag_ausschuesse <- function(safe = TRUE, refresh = FALSE) {
  bundestag_ausschuesse(safe = safe, refresh = refresh)
}

bunddev_bundestag_ausschuss <- function(ausschuss_id, safe = TRUE, refresh = FALSE) {
  bundestag_ausschuss(ausschuss_id = ausschuss_id, safe = safe, refresh = refresh)
}

bunddev_bundestag_mdb_index <- function(safe = TRUE, refresh = FALSE) {
  bundestag_mdb_index(safe = safe, refresh = refresh)
}

bunddev_bundestag_mdb_bio <- function(mdb_id, safe = TRUE, refresh = FALSE) {
  bundestag_mdb_bio(mdb_id = mdb_id, safe = safe, refresh = refresh)
}

bunddev_bundestag_video_feed <- function(content_id, safe = TRUE, refresh = FALSE) {
  bundestag_video_feed(content_id = content_id, safe = safe, refresh = refresh)
}
