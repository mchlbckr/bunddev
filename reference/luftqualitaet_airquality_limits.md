# Get air quality date limits

Get air quality date limits

## Usage

``` r
luftqualitaet_airquality_limits(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with one
row per station. Column names are derived from the `indices` metadata in
the API response and typically include a `station_id` key column
followed by `limit date start min (CET)` and
`limit date start max (CET)`.

## Details

Returns date limits for air quality measurements. API documentation:
<https://luftqualitaet.api.bund.dev>.

## See also

Other Luftqualitaet:
[`luftqualitaet_airquality()`](https://buecker.ms/bunddev/reference/luftqualitaet_airquality.md),
[`luftqualitaet_annualbalances()`](https://buecker.ms/bunddev/reference/luftqualitaet_annualbalances.md),
[`luftqualitaet_components()`](https://buecker.ms/bunddev/reference/luftqualitaet_components.md),
[`luftqualitaet_measures()`](https://buecker.ms/bunddev/reference/luftqualitaet_measures.md),
[`luftqualitaet_measures_limits()`](https://buecker.ms/bunddev/reference/luftqualitaet_measures_limits.md),
[`luftqualitaet_meta()`](https://buecker.ms/bunddev/reference/luftqualitaet_meta.md),
[`luftqualitaet_networks()`](https://buecker.ms/bunddev/reference/luftqualitaet_networks.md),
[`luftqualitaet_scopes()`](https://buecker.ms/bunddev/reference/luftqualitaet_scopes.md),
[`luftqualitaet_stationsettings()`](https://buecker.ms/bunddev/reference/luftqualitaet_stationsettings.md),
[`luftqualitaet_stationtypes()`](https://buecker.ms/bunddev/reference/luftqualitaet_stationtypes.md),
[`luftqualitaet_thresholds()`](https://buecker.ms/bunddev/reference/luftqualitaet_thresholds.md),
[`luftqualitaet_transgressions()`](https://buecker.ms/bunddev/reference/luftqualitaet_transgressions.md),
[`luftqualitaet_transgressiontypes()`](https://buecker.ms/bunddev/reference/luftqualitaet_transgressiontypes.md)
