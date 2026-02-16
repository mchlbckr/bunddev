# Get the current Bundestag speaker

Get the current Bundestag speaker

## Usage

``` r
bundestag_speaker(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A one-row tibble with fields extracted from the XML document (same
structure rules as
[`bundestag_article()`](https://buecker.ms/bunddev/reference/bundestag_article.md)).

## Details

Returns the current speaker from the plenum feed. API documentation:
<https://bundesapi.github.io/bundestag-api/>.

## See also

Other Bundestag:
[`bundestag_article()`](https://buecker.ms/bunddev/reference/bundestag_article.md),
[`bundestag_ausschuesse()`](https://buecker.ms/bunddev/reference/bundestag_ausschuesse.md),
[`bundestag_ausschuss()`](https://buecker.ms/bunddev/reference/bundestag_ausschuss.md),
[`bundestag_conferences()`](https://buecker.ms/bunddev/reference/bundestag_conferences.md),
[`bundestag_mdb_bio()`](https://buecker.ms/bunddev/reference/bundestag_mdb_bio.md),
[`bundestag_mdb_index()`](https://buecker.ms/bunddev/reference/bundestag_mdb_index.md),
[`bundestag_video_feed()`](https://buecker.ms/bunddev/reference/bundestag_video_feed.md)

## Examples

``` r
if (FALSE) { # \dontrun{
bundestag_speaker()
} # }
```
