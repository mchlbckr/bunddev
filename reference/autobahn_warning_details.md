# Get Autobahn warning details

Get Autobahn warning details

## Usage

``` r
autobahn_warning_details(warning_id, flatten = FALSE, flatten_mode = "json")
```

## Arguments

- warning_id:

  Warning identifier.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with warning details.

## Details

Returns full details for a single warning entry. Official docs:
https://autobahn.api.bund.dev.

## See also

[`autobahn_warnings()`](https://mchlbckr.github.io/bunddev/reference/autobahn_warnings.md)
to list warnings.

## Examples

``` r
if (FALSE) { # \dontrun{
roads <- autobahn_roads()
warnings <- autobahn_warnings(roads$road_id[[1]])
autobahn_warning_details(warnings$identifier[[1]])
} # }
```
