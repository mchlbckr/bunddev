# List scopes

List scopes

## Usage

``` r
luftqualitaet_scopes(params = list(), safe = TRUE, refresh = FALSE)
```

## Arguments

- params:

  Named list of query parameters. Common keys:

  date_from

  :   Start date/time filter (character, ISO-8601/date).

  date_to

  :   End date/time filter (character, ISO-8601/date).

  component

  :   Pollutant component id/code (character).

  scope

  :   Scope id/code (character).

  station

  :   Station id/code (character).

  network

  :   Network id/code (character).

  lang

  :   Language code for labels/descriptions (character).

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per scope metadata entry. Top-level scalar API
fields are returned as tibble columns; nested objects or arrays are kept
in list-columns unless the function provides `flatten` / `flatten_mode`
controls.

## Details

Returns scopes used by the Luftqualitaet API. API documentation:
<https://luftqualitaet.api.bund.dev>.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.

Other Luftqualitaet:
[`luftqualitaet_airquality()`](https://buecker.ms/bunddev/reference/luftqualitaet_airquality.md),
[`luftqualitaet_airquality_limits()`](https://buecker.ms/bunddev/reference/luftqualitaet_airquality_limits.md),
[`luftqualitaet_annualbalances()`](https://buecker.ms/bunddev/reference/luftqualitaet_annualbalances.md),
[`luftqualitaet_components()`](https://buecker.ms/bunddev/reference/luftqualitaet_components.md),
[`luftqualitaet_measures()`](https://buecker.ms/bunddev/reference/luftqualitaet_measures.md),
[`luftqualitaet_measures_limits()`](https://buecker.ms/bunddev/reference/luftqualitaet_measures_limits.md),
[`luftqualitaet_meta()`](https://buecker.ms/bunddev/reference/luftqualitaet_meta.md),
[`luftqualitaet_networks()`](https://buecker.ms/bunddev/reference/luftqualitaet_networks.md),
[`luftqualitaet_stationsettings()`](https://buecker.ms/bunddev/reference/luftqualitaet_stationsettings.md),
[`luftqualitaet_stationtypes()`](https://buecker.ms/bunddev/reference/luftqualitaet_stationtypes.md),
[`luftqualitaet_thresholds()`](https://buecker.ms/bunddev/reference/luftqualitaet_thresholds.md),
[`luftqualitaet_transgressions()`](https://buecker.ms/bunddev/reference/luftqualitaet_transgressions.md),
[`luftqualitaet_transgressiontypes()`](https://buecker.ms/bunddev/reference/luftqualitaet_transgressiontypes.md)
