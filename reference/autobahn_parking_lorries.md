# List Autobahn lorry parking areas

List Autobahn lorry parking areas

## Usage

``` r
autobahn_parking_lorries(road_id, flatten = FALSE, flatten_mode = "json")
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

A tibble with lorry parking areas.

## Details

Returns lorry parking areas for a specific Autobahn road id. Official
docs: https://autobahn.api.bund.dev.

## See also

[`autobahn_roads()`](https://mchlbckr.github.io/bunddev/reference/autobahn_roads.md)
and
[`autobahn_parking_lorry_details()`](https://mchlbckr.github.io/bunddev/reference/autobahn_parking_lorry_details.md).

## Examples

``` r
if (FALSE) { # \dontrun{
roads <- autobahn_roads()
autobahn_parking_lorries(roads$road_id[[1]], flatten = TRUE)
} # }
```
