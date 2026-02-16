# List thresholds

List thresholds

## Usage

``` r
luftqualitaet_thresholds(params = list(), safe = TRUE, refresh = FALSE)
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

A tibble with one row per threshold metadata entry.

- Indexed value columns:

  Columns are derived from API `indices` metadata and represent scalar
  values for each returned record.

- Index key column:

  Included when the API provides a named index key (for example station
  id/date key).

## Details

Returns threshold metadata for components and scopes. API documentation:
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
[`luftqualitaet_scopes()`](https://buecker.ms/bunddev/reference/luftqualitaet_scopes.md),
[`luftqualitaet_stationsettings()`](https://buecker.ms/bunddev/reference/luftqualitaet_stationsettings.md),
[`luftqualitaet_stationtypes()`](https://buecker.ms/bunddev/reference/luftqualitaet_stationtypes.md),
[`luftqualitaet_transgressions()`](https://buecker.ms/bunddev/reference/luftqualitaet_transgressions.md),
[`luftqualitaet_transgressiontypes()`](https://buecker.ms/bunddev/reference/luftqualitaet_transgressiontypes.md)
