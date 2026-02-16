# Get Autobahn lorry parking details

Get Autobahn lorry parking details

## Usage

``` r
autobahn_parking_lorry_details(
  lorry_id,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- lorry_id:

  Lorry parking identifier.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with lorry parking details.

## Details

Returns full details for a single lorry parking entry. Official docs:
https://autobahn.api.bund.dev.

## See also

[`autobahn_parking_lorries()`](https://mchlbckr.github.io/bunddev/reference/autobahn_parking_lorries.md)
to list parking areas.

## Examples

``` r
if (FALSE) { # \dontrun{
roads <- autobahn_roads()
parking <- autobahn_parking_lorries(roads$road_id[[1]])
autobahn_parking_lorry_details(parking$identifier[[1]])
} # }
```
