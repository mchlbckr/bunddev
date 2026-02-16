# List Dashboard Deutschland entries

List Dashboard Deutschland entries

## Usage

``` r
dashboard_deutschland_get(
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

- flatten:

  Logical; if `TRUE`, simplify nested list columns according to
  `flatten_mode`. Default `FALSE` keeps list columns as-is.

- flatten_mode:

  How to handle list columns when `flatten = TRUE`:

  `"drop"`

  :   Remove list columns entirely. Use when nested data is not needed.

  `"json"`

  :   Convert each list element to a JSON string. Preserves all data in
      a text-queryable format. This is the **default**.

  `"unnest"`

  :   Expand list columns into multiple rows via
      [`tidyr::unnest_longer()`](https://tidyr.tidyverse.org/reference/unnest_longer.html).
      **Warning:** this can significantly increase the number of rows.

## Value

A tibble with one row per dashboard tile:

- id:

  Tile identifier (character).

- name:

  Title in German (character).

- name_en:

  Title in English (character).

- description:

  Description in German (character).

- description_en:

  Description in English (character).

- teaser:

  Teaser text in German (character).

- teaser_en:

  Teaser text in English (character).

- conclusion:

  Conclusion text in German (character).

- conclusion_en:

  Conclusion text in English (character).

- category:

  Category metadata (list-column).

- tags:

  Tag metadata (list-column).

- image:

  Image path/url (character).

- clicks:

  Click counter (integer).

- order_id:

  Ordering index (integer).

- trending:

  Whether tile is marked as trending (`TRUE`/`FALSE`).

- top:

  Whether tile is marked as top (`TRUE`/`FALSE`).

- layout_tiles:

  Layout tile metadata (list-column).

- layout_mode:

  Layout mode identifier (character).

## Details

Returns the full list of dashboard entries and metadata for each item.
API documentation:
<https://bundesapi.github.io/dashboard-deutschland-api/>.

## See also

Other Dashboard Deutschland:
[`dashboard_deutschland_geo()`](https://buecker.ms/bunddev/reference/dashboard_deutschland_geo.md),
[`dashboard_deutschland_indicators()`](https://buecker.ms/bunddev/reference/dashboard_deutschland_indicators.md)

## Examples

``` r
if (FALSE) { # \dontrun{
dashboard_deutschland_get()
} # }
```
