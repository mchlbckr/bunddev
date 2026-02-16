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

The Pegel-Online API provides water level station metadata. Use query
parameters to filter stations by water, ids, or location. Official docs:
https://pegel-online.api.bund.dev.

## See also

[`pegel_online_station()`](https://mchlbckr.github.io/bunddev/reference/pegel_online_station.md)
for a single station and
[`pegel_online_measurements()`](https://mchlbckr.github.io/bunddev/reference/pegel_online_measurements.md)
for time series values.

## Examples

``` r
if (FALSE) { # \dontrun{
pegel_online_stations(params = list(limit = 5))
} # }
```
