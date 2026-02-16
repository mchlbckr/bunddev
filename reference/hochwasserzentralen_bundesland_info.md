# Get flood portal metadata for a Bundesland

Get flood portal metadata for a Bundesland

## Usage

``` r
hochwasserzentralen_bundesland_info(
  bundesland_id,
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- bundesland_id:

  Bundesland id (e.g., "HE").

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row of metadata for the selected Bundesland id.
Guaranteed columns are top-level scalar fields from returned JSON
objects or GeoJSON feature properties; `features` is used as a
list-column for GeoJSON container endpoints.

## Details

Returns metadata for a single Bundesland or region in the
hochwasserzentralen.de portal. API documentation:
<https://bundesapi.github.io/hochwasserzentralen-api/>.

## See also

Other Hochwasserzentralen:
[`hochwasserzentralen_bundeslaender()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_bundeslaender.md),
[`hochwasserzentralen_bundesland_geojson()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_bundesland_geojson.md),
[`hochwasserzentralen_lagepegel()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_lagepegel.md),
[`hochwasserzentralen_pegel_info()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_pegel_info.md)

## Examples

``` r
if (FALSE) { # \dontrun{
hochwasserzentralen_bundesland_info("HE")
} # }
```
