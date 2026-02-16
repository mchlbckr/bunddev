# List Autobahn roadworks

List Autobahn roadworks

## Usage

``` r
autobahn_roadworks(road_id, flatten = FALSE, flatten_mode = "json")
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

A tibble with roadworks.

## Details

Returns current roadworks for a specific Autobahn road id. Official
docs: https://autobahn.api.bund.dev.

## See also

[`autobahn_roads()`](https://buecker.ms/bunddev/reference/autobahn_roads.md)
to list available roads, and
[`autobahn_roadwork_details()`](https://buecker.ms/bunddev/reference/autobahn_roadwork_details.md)
for detail records.

## Examples

``` r
if (FALSE) { # \dontrun{
roads <- autobahn_roads()
autobahn_roadworks(roads$road_id[[1]], flatten = TRUE)
} # }
```
