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

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with raw PNG bytes.

## Details

Returns a PNG plot for the measurements endpoint. Official docs:
https://pegel-online.api.bund.dev.

## See also

[`pegel_online_measurements()`](https://buecker.ms/bunddev/reference/pegel_online_measurements.md)
for numeric values.

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
