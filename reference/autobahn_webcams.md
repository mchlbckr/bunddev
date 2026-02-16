# List Autobahn webcams

List Autobahn webcams

## Usage

``` r
autobahn_webcams(road_id, flatten = FALSE, flatten_mode = "json")
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

A tibble with webcams.

## Details

Returns webcam entries for a specific Autobahn road id. Official docs:
https://autobahn.api.bund.dev.

## See also

[`autobahn_roads()`](https://buecker.ms/bunddev/reference/autobahn_roads.md)
and
[`autobahn_webcam_details()`](https://buecker.ms/bunddev/reference/autobahn_webcam_details.md).

## Examples

``` r
if (FALSE) { # \dontrun{
roads <- autobahn_roads()
autobahn_webcams(roads$road_id[[1]], flatten = TRUE)
} # }
```
