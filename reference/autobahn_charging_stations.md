# List Autobahn charging stations

List Autobahn charging stations

## Usage

``` r
autobahn_charging_stations(road_id, flatten = FALSE, flatten_mode = "json")
```

## Arguments

- road_id:

  Road identifier.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with charging stations.

## Details

Returns charging stations for a specific Autobahn road id. Official
docs: https://autobahn.api.bund.dev.

## See also

[`autobahn_roads()`](https://mchlbckr.github.io/bunddev/reference/autobahn_roads.md)
and
[`autobahn_charging_station_details()`](https://mchlbckr.github.io/bunddev/reference/autobahn_charging_station_details.md).

## Examples

``` r
if (FALSE) { # \dontrun{
roads <- autobahn_roads()
autobahn_charging_stations(roads$road_id[[1]], flatten = TRUE)
} # }
```
