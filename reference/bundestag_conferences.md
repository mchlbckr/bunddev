# Get Bundestag conferences overview

Get Bundestag conferences overview

## Usage

``` r
bundestag_conferences(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per `<item>` entry from the conferences feed.
Column names correspond to XML element names.

- XML child-tag columns:

  One column per scalar child element in each `<item>` entry (or
  root-level document field for single-document endpoints).

- Repeated child tags:

  Stored as list-columns.

## Details

Returns conference overview data from the plenum feed. API
documentation: <https://bundesapi.github.io/bundestag-api/>.

## See also

Other Bundestag:
[`bundestag_article()`](https://buecker.ms/bunddev/reference/bundestag_article.md),
[`bundestag_ausschuesse()`](https://buecker.ms/bunddev/reference/bundestag_ausschuesse.md),
[`bundestag_ausschuss()`](https://buecker.ms/bunddev/reference/bundestag_ausschuss.md),
[`bundestag_mdb_bio()`](https://buecker.ms/bunddev/reference/bundestag_mdb_bio.md),
[`bundestag_mdb_index()`](https://buecker.ms/bunddev/reference/bundestag_mdb_index.md),
[`bundestag_speaker()`](https://buecker.ms/bunddev/reference/bundestag_speaker.md),
[`bundestag_video_feed()`](https://buecker.ms/bunddev/reference/bundestag_video_feed.md)

## Examples

``` r
if (FALSE) { # \dontrun{
bundestag_conferences()
} # }
```
