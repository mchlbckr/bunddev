# Get Pegel-Online measurements plot

Get Pegel-Online measurements plot

## Usage

``` r
pegel_online_measurements_plot(
  station,
  timeseries,
  start = NULL,
  end = NULL,
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- station:

  Station UUID, name, or number.

- timeseries:

  Timeseries shortname.

- start:

  Start timestamp in ISO 8601.

- end:

  End timestamp in ISO 8601.

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A one-row tibble with:

- station:

  Requested station id (character).

- timeseries:

  Requested timeseries shortname (character).

- png:

  Raw PNG bytes (list-column with raw vector).

## Details

Returns a PNG plot for the measurements endpoint. API documentation:
<https://pegel-online.api.bund.dev>.

## See also

[`pegel_online_measurements()`](https://buecker.ms/bunddev/reference/pegel_online_measurements.md)
for numeric values.

Other Pegel Online:
[`pegel_online_measurements()`](https://buecker.ms/bunddev/reference/pegel_online_measurements.md),
[`pegel_online_station()`](https://buecker.ms/bunddev/reference/pegel_online_station.md),
[`pegel_online_stations()`](https://buecker.ms/bunddev/reference/pegel_online_stations.md),
[`pegel_online_timeseries()`](https://buecker.ms/bunddev/reference/pegel_online_timeseries.md),
[`pegel_online_waters()`](https://buecker.ms/bunddev/reference/pegel_online_waters.md)

## Examples

``` r
if (FALSE) { # \dontrun{
stations <- pegel_online_stations(params = list(limit = 1))
pegel_online_measurements_plot(stations$uuid[[1]], "W",
  start = "2024-01-01T00:00:00Z",
  end = "2024-01-02T00:00:00Z"
)
} # }
```
