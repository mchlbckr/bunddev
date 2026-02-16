# Get Autobahn charging station details

Get Autobahn charging station details

## Usage

``` r
autobahn_charging_station_details(
  station_id,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- station_id:

  Charging station identifier.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with charging station details.

## Details

Returns full details for a single charging station entry. Official docs:
https://autobahn.api.bund.dev.

## See also

[`autobahn_charging_stations()`](https://buecker.ms/bunddev/reference/autobahn_charging_stations.md)
to list stations.

## Examples

``` r
if (FALSE) { # \dontrun{
roads <- autobahn_roads()
stations <- autobahn_charging_stations(roads$road_id[[1]])
autobahn_charging_station_details(stations$identifier[[1]])
} # }
```
