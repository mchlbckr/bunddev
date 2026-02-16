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

  Query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with timeseries metadata.

## Details

Returns metadata for a timeseries, including unit and gauge zero.
Official docs: https://pegel-online.api.bund.dev.

## See also

[`pegel_online_measurements()`](https://buecker.ms/bunddev/reference/pegel_online_measurements.md)
for measurement values.

## Examples

``` r
if (FALSE) { # \dontrun{
stations <- pegel_online_stations(params = list(limit = 1))
pegel_online_timeseries(stations$uuid[[1]], "W")
} # }
```
