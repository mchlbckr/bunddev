# List Autobahn warnings

List Autobahn warnings

## Usage

``` r
autobahn_warnings(road_id, flatten = FALSE, flatten_mode = "json")
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

A tibble with warnings.

## Details

Returns current warnings for a specific Autobahn road id. Official docs:
https://autobahn.api.bund.dev.

## See also

[`autobahn_roads()`](https://buecker.ms/bunddev/reference/autobahn_roads.md)
to list roads and
[`autobahn_warning_details()`](https://buecker.ms/bunddev/reference/autobahn_warning_details.md)
for details.

## Examples

``` r
if (FALSE) { # \dontrun{
roads <- autobahn_roads()
autobahn_warnings(roads$road_id[[1]], flatten = TRUE)
} # }
```
