# List Bundestag members of parliament

List Bundestag members of parliament

## Usage

``` r
bundestag_mdb_index(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per member `<item>` from the index feed. Column
names correspond to XML child element names within each `<item>`.

- `<tag>`:

  One column per unique scalar child element in each `<item>`
  (character). Exact names depend on the feed structure.

- `<repeated_tag>`:

  List-column when a child element name appears more than once in a
  single `<item>`.

## Details

Returns the index of members of parliament. API documentation:
<https://bundesapi.github.io/bundestag-api/>.

## See also

Other Bundestag:
[`bundestag_article()`](https://buecker.ms/bunddev/reference/bundestag_article.md),
[`bundestag_ausschuesse()`](https://buecker.ms/bunddev/reference/bundestag_ausschuesse.md),
[`bundestag_ausschuss()`](https://buecker.ms/bunddev/reference/bundestag_ausschuss.md),
[`bundestag_conferences()`](https://buecker.ms/bunddev/reference/bundestag_conferences.md),
[`bundestag_mdb_bio()`](https://buecker.ms/bunddev/reference/bundestag_mdb_bio.md),
[`bundestag_speaker()`](https://buecker.ms/bunddev/reference/bundestag_speaker.md),
[`bundestag_video_feed()`](https://buecker.ms/bunddev/reference/bundestag_video_feed.md)

## Examples

``` r
if (FALSE) { # \dontrun{
bundestag_mdb_index()
} # }
```
