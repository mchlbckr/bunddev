# Get flood gauge information

Get flood gauge information

## Usage

``` r
hochwasserzentralen_pegel_info(pegelnummer, safe = TRUE, refresh = FALSE)
```

## Arguments

- pegelnummer:

  Pegelnummer identifier (e.g., "HE_24820206").

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row of gauge metadata for the selected `pegelnummer`.
Columns follow the upstream service field names.

## Details

Returns metadata for a single flood gauge (pegel) from
hochwasserzentralen.de. API documentation:
<https://bundesapi.github.io/hochwasserzentralen-api/>.

## See also

Other Hochwasserzentralen:
[`hochwasserzentralen_bundeslaender()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_bundeslaender.md),
[`hochwasserzentralen_bundesland_geojson()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_bundesland_geojson.md),
[`hochwasserzentralen_bundesland_info()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_bundesland_info.md),
[`hochwasserzentralen_lagepegel()`](https://buecker.ms/bunddev/reference/hochwasserzentralen_lagepegel.md)

## Examples

``` r
if (FALSE) { # \dontrun{
hochwasserzentralen_pegel_info("HE_24820206")
} # }
```
