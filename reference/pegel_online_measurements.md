# Get Pegel-Online measurements

Get Pegel-Online measurements

## Usage

``` r
pegel_online_measurements(
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

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with measurements.

Includes `timestamp_time` as POSIXct in Europe/Berlin.

## Details

Returns measurement values for a station timeseries. Timestamps must be
ISO 8601 strings. Official docs: https://pegel-online.api.bund.dev.

## See also

[`pegel_online_timeseries()`](https://buecker.ms/bunddev/reference/pegel_online_timeseries.md)
for metadata and
[`pegel_online_measurements_plot()`](https://buecker.ms/bunddev/reference/pegel_online_measurements_plot.md)
for PNG plots.

## Examples

``` r
if (FALSE) { # \dontrun{
stations <- pegel_online_stations(params = list(limit = 1))
pegel_online_measurements(stations$uuid[[1]], "W",
  start = "2024-01-01T00:00:00Z",
  end = "2024-01-02T00:00:00Z"
)
} # }
```
