# List flood portal states and connected regions

List flood portal states and connected regions

## Usage

``` r
hochwasserzentralen_bundeslaender(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per Bundesland/region entry. Column names follow
the upstream service field names. Top-level scalar API fields are
returned as tibble columns; nested objects or arrays are kept in
list-columns unless the function provides `flatten` / `flatten_mode`
controls.

## Details

Returns metadata for all Bundeslaender and connected regions in the
hochwasserzentralen.de portal. API documentation:
<https://bundesapi.github.io/hochwasserzentralen-api/>.

## See also

Other Hochwasserzentralen:
[`hochwasserzentralen_bundesland_geojson()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_bundesland_geojson.md),
[`hochwasserzentralen_bundesland_info()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_bundesland_info.md),
[`hochwasserzentralen_lagepegel()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_lagepegel.md),
[`hochwasserzentralen_pegel_info()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_pegel_info.md)

## Examples

``` r
if (FALSE) { # \dontrun{
hochwasserzentralen_bundeslaender()
} # }
```
