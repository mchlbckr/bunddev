# Get a Bundestag news article

Get a Bundestag news article

## Usage

``` r
bundestag_article(article_id, safe = TRUE, refresh = FALSE)
```

## Arguments

- article_id:

  Article id.

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A one-row tibble with fields extracted from the XML document. Column
names correspond to XML element names; repeated elements are
list-columns.

- Scalar fields:

  One column per top-level scalar field returned by the endpoint.

- Nested fields:

  Kept as list-columns; for endpoints with `flatten` controls these can
  be transformed.

## Details

Returns a single Bundestag news article in XML format. API
documentation: <https://bundesapi.github.io/bundestag-api/>.

## See also

Other Bundestag:
[`bundestag_ausschuesse()`](https://buecker.ms/bunddev/reference/bundestag_ausschuesse.md),
[`bundestag_ausschuss()`](https://buecker.ms/bunddev/reference/bundestag_ausschuss.md),
[`bundestag_conferences()`](https://buecker.ms/bunddev/reference/bundestag_conferences.md),
[`bundestag_mdb_bio()`](https://buecker.ms/bunddev/reference/bundestag_mdb_bio.md),
[`bundestag_mdb_index()`](https://buecker.ms/bunddev/reference/bundestag_mdb_index.md),
[`bundestag_speaker()`](https://buecker.ms/bunddev/reference/bundestag_speaker.md),
[`bundestag_video_feed()`](https://buecker.ms/bunddev/reference/bundestag_video_feed.md)

## Examples

``` r
if (FALSE) { # \dontrun{
bundestag_article(849630)
} # }
```
