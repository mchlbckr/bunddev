# Get a Bundestag video feed entry

Get a Bundestag video feed entry

## Usage

``` r
bundestag_video_feed(content_id, safe = TRUE, refresh = FALSE)
```

## Arguments

- content_id:

  Video content id.

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A one-row tibble with video feed fields extracted from XML.

- XML child-tag columns:

  One column per scalar child element in each `<item>` entry (or
  root-level document field for single-document endpoints).

- Repeated child tags:

  Stored as list-columns.

## Details

Returns a video feed entry from the Bundestag webtv service. API
documentation: <https://bundesapi.github.io/bundestag-api/>.

## See also

Other Bundestag:
[`bundestag_article()`](https://buecker.ms/bunddev/reference/bundestag_article.md),
[`bundestag_ausschuesse()`](https://buecker.ms/bunddev/reference/bundestag_ausschuesse.md),
[`bundestag_ausschuss()`](https://buecker.ms/bunddev/reference/bundestag_ausschuss.md),
[`bundestag_conferences()`](https://buecker.ms/bunddev/reference/bundestag_conferences.md),
[`bundestag_mdb_bio()`](https://buecker.ms/bunddev/reference/bundestag_mdb_bio.md),
[`bundestag_mdb_index()`](https://buecker.ms/bunddev/reference/bundestag_mdb_index.md),
[`bundestag_speaker()`](https://buecker.ms/bunddev/reference/bundestag_speaker.md)

## Examples

``` r
if (FALSE) { # \dontrun{
bundestag_video_feed(7529016)
} # }
```
