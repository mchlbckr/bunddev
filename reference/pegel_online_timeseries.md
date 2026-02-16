# Get Pegel-Online timeseries metadata

Get Pegel-Online timeseries metadata

## Usage

``` r
pegel_online_timeseries(
  station,
  timeseries,
  params = list(),
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- station:

  Station UUID, name, or number.

- timeseries:

  Timeseries shortname.

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

## Value

A one-row tibble with timeseries metadata:

- shortname:

  Timeseries shortname (character).

- longname:

  Timeseries long name (character).

- unit:

  Measurement unit (character).

- equidistance:

  Sampling interval/equidistance (numeric).

- gauge_zero:

  Gauge zero metadata (list-column).

- characteristic_values:

  Characteristic values (list-column).

- current_value:

  Current measured value (numeric).

- current_timestamp:

  Current timestamp as string (character).

- current_timestamp_time:

  Current timestamp as `POSIXct` in Europe/Berlin.

## Details

Returns metadata for a timeseries, including unit and gauge zero.
Official docs: https://pegel-online.api.bund.dev.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.
[`pegel_online_measurements()`](https://buecker.ms/bunddev/reference/pegel_online_measurements.md)
for measurement values.

Other Pegel Online:
[`pegel_online_measurements()`](https://buecker.ms/bunddev/reference/pegel_online_measurements.md),
[`pegel_online_measurements_plot()`](https://buecker.ms/bunddev/reference/pegel_online_measurements_plot.md),
[`pegel_online_station()`](https://buecker.ms/bunddev/reference/pegel_online_station.md),
[`pegel_online_stations()`](https://buecker.ms/bunddev/reference/pegel_online_stations.md),
[`pegel_online_waters()`](https://buecker.ms/bunddev/reference/pegel_online_waters.md)

## Examples

``` r
if (FALSE) { # \dontrun{
stations <- pegel_online_stations(params = list(limit = 1))
pegel_online_timeseries(stations$uuid[[1]], "W")
} # }
```
