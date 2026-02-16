# Get Dashboard Deutschland GeoJSON

Get Dashboard Deutschland GeoJSON

## Usage

``` r
dashboard_deutschland_geo(
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

A one-row tibble with GeoJSON container metadata:

- type:

  GeoJSON object type (character).

- name:

  Dataset name (character).

- title:

  Dataset title (character).

- version:

  Version identifier (character).

- copyright_short:

  Short copyright label (character).

- copyright_url:

  Copyright URL (character).

- crs:

  Coordinate reference system metadata (list-column).

- features:

  GeoJSON feature collection entries (list-column).

## Details

Returns GeoJSON data for Germany and the federal states. API
documentation: <https://bundesapi.github.io/dashboard-deutschland-api/>.

## See also

Other Dashboard Deutschland:
[`dashboard_deutschland_get()`](https://buecker.ms/bunddev/reference/dashboard_deutschland_get.md),
[`dashboard_deutschland_indicators()`](https://buecker.ms/bunddev/reference/dashboard_deutschland_indicators.md)

## Examples

``` r
if (FALSE) { # \dontrun{
dashboard_deutschland_geo(flatten = TRUE)
} # }
```
