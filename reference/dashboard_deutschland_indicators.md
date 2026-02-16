# Query Dashboard Deutschland indicators

Query Dashboard Deutschland indicators

## Usage

``` r
dashboard_deutschland_indicators(ids = NULL, safe = TRUE, refresh = FALSE)
```

## Arguments

- ids:

  Indicator ids, semicolon-separated or as a character vector.

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per indicator entry:

- id:

  Indicator id (character).

- date:

  Timestamp in milliseconds since epoch (numeric).

- date_time:

  Timestamp as `POSIXct` in Europe/Berlin.

- json:

  Indicator payload as JSON string (character).

- title:

  Indicator title (character).

## Details

Returns indicator data for the specified ids. API documentation:
<https://bundesapi.github.io/dashboard-deutschland-api/>.

## See also

Other Dashboard Deutschland:
[`dashboard_deutschland_geo()`](https://buecker.ms/bunddev/reference/dashboard_deutschland_geo.md),
[`dashboard_deutschland_get()`](https://buecker.ms/bunddev/reference/dashboard_deutschland_get.md)

## Examples

``` r
if (FALSE) { # \dontrun{
dashboard_deutschland_indicators("tile_1667811574092")
} # }
```
