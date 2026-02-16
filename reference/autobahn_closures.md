# List Autobahn closures

List Autobahn closures

## Usage

``` r
autobahn_closures(road_id, flatten = FALSE, flatten_mode = "json")
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

A tibble with closures.

## Details

Returns current closures for a specific Autobahn road id. Official docs:
https://autobahn.api.bund.dev.

## See also

[`autobahn_roads()`](https://mchlbckr.github.io/bunddev/reference/autobahn_roads.md)
and
[`autobahn_closure_details()`](https://mchlbckr.github.io/bunddev/reference/autobahn_closure_details.md).

## Examples

``` r
if (FALSE) { # \dontrun{
roads <- autobahn_roads()
autobahn_closures(roads$road_id[[1]], flatten = TRUE)
} # }
```
