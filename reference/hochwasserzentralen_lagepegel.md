# List flood gauge locations

List flood gauge locations

## Usage

``` r
hochwasserzentralen_lagepegel(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per gauge location and coordinate metadata.

- Top-level fields:

  One column per scalar top-level field (or per GeoJSON feature
  `properties` field).

- Nested fields:

  Stored as list-columns.

- features:

  GeoJSON container endpoint: feature collection as list-column.

## Details

Returns latitude/longitude coordinates for all pegel identifiers
available in the hochwasserzentralen.de portal. API documentation:
<https://bundesapi.github.io/hochwasserzentralen-api/>.

## See also

Other Hochwasserzentralen:
[`hochwasserzentralen_bundeslaender()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_bundeslaender.md),
[`hochwasserzentralen_bundesland_geojson()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_bundesland_geojson.md),
[`hochwasserzentralen_bundesland_info()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_bundesland_info.md),
[`hochwasserzentralen_pegel_info()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_pegel_info.md)

## Examples

``` r
if (FALSE) { # \dontrun{
hochwasserzentralen_lagepegel()
} # }
```
