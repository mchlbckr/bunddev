# Get Bundesland GeoJSON boundaries

Get Bundesland GeoJSON boundaries

## Usage

``` r
hochwasserzentralen_bundesland_geojson(
  version,
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- version:

  GeoJSON version identifier (e.g., "20211130").

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

A one-row tibble with:

- type:

  GeoJSON object type (character).

- name:

  GeoJSON dataset name (character).

- features:

  GeoJSON feature list (list-column).

## Details

Returns GeoJSON boundaries for Bundeslaender and connected regions from
the hochwasserzentralen.de portal. API documentation:
<https://bundesapi.github.io/hochwasserzentralen-api/>.

## See also

Other Hochwasserzentralen:
[`hochwasserzentralen_bundeslaender()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_bundeslaender.md),
[`hochwasserzentralen_bundesland_info()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_bundesland_info.md),
[`hochwasserzentralen_lagepegel()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_lagepegel.md),
[`hochwasserzentralen_pegel_info()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_pegel_info.md)

## Examples

``` r
if (FALSE) { # \dontrun{
hochwasserzentralen_bundesland_geojson("20211130", flatten = TRUE)
} # }
```
