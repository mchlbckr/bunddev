# Get a Pegel-Online station

Get a Pegel-Online station

## Usage

``` r
pegel_online_station(
  station,
  params = list(),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- station:

  Station UUID, name, or number.

- params:

  Query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with station metadata.

## Details

Fetches a single station record. Official docs:
https://pegel-online.api.bund.dev.

## See also

[`pegel_online_stations()`](https://buecker.ms/bunddev/reference/pegel_online_stations.md)
and
[`pegel_online_timeseries()`](https://buecker.ms/bunddev/reference/pegel_online_timeseries.md).

## Examples

``` r
if (FALSE) { # \dontrun{
stations <- pegel_online_stations(params = list(limit = 1))
pegel_online_station(stations$uuid[[1]])
} # }
```
