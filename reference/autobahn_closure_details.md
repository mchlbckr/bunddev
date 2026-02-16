# Get Autobahn closure details

Get Autobahn closure details

## Usage

``` r
autobahn_closure_details(closure_id, flatten = FALSE, flatten_mode = "json")
```

## Arguments

- closure_id:

  Closure identifier.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with closure details.

## Details

Returns full details for a single closure entry. Official docs:
https://autobahn.api.bund.dev.

## See also

[`autobahn_closures()`](https://buecker.ms/bunddev/reference/autobahn_closures.md)
to list closures.

## Examples

``` r
if (FALSE) { # \dontrun{
roads <- autobahn_roads()
closures <- autobahn_closures(roads$road_id[[1]])
autobahn_closure_details(closures$identifier[[1]])
} # }
```
