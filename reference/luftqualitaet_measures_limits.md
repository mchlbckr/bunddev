# Get measurement date limits

Get measurement date limits

## Usage

``` r
luftqualitaet_measures_limits(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A one-row tibble with available date limits for the endpoint.

## Details

Returns date limits for measurement metadata. API documentation:
<https://luftqualitaet.api.bund.dev>.

## See also

Other Luftqualitaet:
[`luftqualitaet_airquality()`](https://buecker.ms/bunddev/reference/luftqualitaet_airquality.md),
[`luftqualitaet_airquality_limits()`](https://buecker.ms/bunddev/reference/luftqualitaet_airquality_limits.md),
[`luftqualitaet_annualbalances()`](https://buecker.ms/bunddev/reference/luftqualitaet_annualbalances.md),
[`luftqualitaet_components()`](https://buecker.ms/bunddev/reference/luftqualitaet_components.md),
[`luftqualitaet_measures()`](https://buecker.ms/bunddev/reference/luftqualitaet_measures.md),
[`luftqualitaet_meta()`](https://buecker.ms/bunddev/reference/luftqualitaet_meta.md),
[`luftqualitaet_networks()`](https://buecker.ms/bunddev/reference/luftqualitaet_networks.md),
[`luftqualitaet_scopes()`](https://buecker.ms/bunddev/reference/luftqualitaet_scopes.md),
[`luftqualitaet_stationsettings()`](https://buecker.ms/bunddev/reference/luftqualitaet_stationsettings.md),
[`luftqualitaet_stationtypes()`](https://buecker.ms/bunddev/reference/luftqualitaet_stationtypes.md),
[`luftqualitaet_thresholds()`](https://buecker.ms/bunddev/reference/luftqualitaet_thresholds.md),
[`luftqualitaet_transgressions()`](https://buecker.ms/bunddev/reference/luftqualitaet_transgressions.md),
[`luftqualitaet_transgressiontypes()`](https://buecker.ms/bunddev/reference/luftqualitaet_transgressiontypes.md)
