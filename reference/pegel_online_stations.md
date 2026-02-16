# List Pegel-Online stations

List Pegel-Online stations

## Usage

``` r
pegel_online_stations(
  params = list(),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- params:

  Named list of query parameters:

  includeTimeseries

  :   Include timeseries metadata (`TRUE`/`FALSE`).

  includeCurrentMeasurement

  :   Include current measurement metadata (`TRUE`/`FALSE`).

  includeCharacteristicValues

  :   Include characteristic values (`TRUE`/`FALSE`).

  waters

  :   Filter by water shortnames (character vector).

  ids

  :   Filter by station ids (character vector).

  timeseries

  :   Timeseries shortname filter (character).

  fuzzyId

  :   Fuzzy station id/name search (character).

  latitude

  :   Latitude center for geo search (numeric).

  longitude

  :   Longitude center for geo search (numeric).

  radius

  :   Radius for geo search (numeric).

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

A tibble with one row per station:

- uuid:

  Station UUID (character).

- number:

  Station number/code (character).

- shortname:

  Short station name (character).

- longname:

  Long station name (character).

- km:

  River kilometer (numeric).

- agency:

  Responsible agency (character).

- longitude:

  Longitude (numeric).

- latitude:

  Latitude (numeric).

- water:

  Water metadata (list-column).

- timeseries:

  Timeseries metadata (list-column).

## Details

The Pegel-Online API provides water level station metadata. Use query
parameters to filter stations by water, ids, or location. API
documentation: <https://pegel-online.api.bund.dev>.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.
[`pegel_online_station()`](https://buecker.ms/bunddev/reference/pegel_online_station.md)
for a single station and
[`pegel_online_measurements()`](https://buecker.ms/bunddev/reference/pegel_online_measurements.md)
for time series values.

Other Pegel Online:
[`pegel_online_measurements()`](https://buecker.ms/bunddev/reference/pegel_online_measurements.md),
[`pegel_online_measurements_plot()`](https://buecker.ms/bunddev/reference/pegel_online_measurements_plot.md),
[`pegel_online_station()`](https://buecker.ms/bunddev/reference/pegel_online_station.md),
[`pegel_online_timeseries()`](https://buecker.ms/bunddev/reference/pegel_online_timeseries.md),
[`pegel_online_waters()`](https://buecker.ms/bunddev/reference/pegel_online_waters.md)

## Examples

``` r
if (FALSE) { # \dontrun{
pegel_online_stations(params = list(limit = 5))
} # }
```
