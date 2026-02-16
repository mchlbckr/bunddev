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
names correspond to XML element names.

- `<tag>`:

  One column per unique scalar child element of the XML root
  (character). Exact names depend on the XML document structure.

- `<repeated_tag>`:

  List-column when a child element name appears more than once.

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
