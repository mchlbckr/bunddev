# Get a Bundestag biography

Get a Bundestag biography

## Usage

``` r
bundestag_mdb_bio(mdb_id, safe = TRUE, refresh = FALSE)
```

## Arguments

- mdb_id:

  Member id.

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A one-row tibble with biography fields extracted from XML. Column names
correspond to XML element names.

- `<tag>`:

  One column per unique scalar child element of the XML root
  (character). Exact names depend on the XML document structure.

- `<repeated_tag>`:

  List-column when a child element name appears more than once.

## Details

Returns details for a single member of parliament. API documentation:
<https://bundesapi.github.io/bundestag-api/>.

## See also

Other Bundestag:
[`bundestag_article()`](https://buecker.ms/bunddev/reference/bundestag_article.md),
[`bundestag_ausschuesse()`](https://buecker.ms/bunddev/reference/bundestag_ausschuesse.md),
[`bundestag_ausschuss()`](https://buecker.ms/bunddev/reference/bundestag_ausschuss.md),
[`bundestag_conferences()`](https://buecker.ms/bunddev/reference/bundestag_conferences.md),
[`bundestag_mdb_index()`](https://buecker.ms/bunddev/reference/bundestag_mdb_index.md),
[`bundestag_speaker()`](https://buecker.ms/bunddev/reference/bundestag_speaker.md),
[`bundestag_video_feed()`](https://buecker.ms/bunddev/reference/bundestag_video_feed.md)

## Examples

``` r
if (FALSE) { # \dontrun{
bundestag_mdb_bio(1769)
} # }
```
