# Get Autobahn roadwork details

Get Autobahn roadwork details

## Usage

``` r
autobahn_roadwork_details(roadwork_id, flatten = FALSE, flatten_mode = "json")
```

## Arguments

- roadwork_id:

  Roadwork identifier.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with roadwork details.

## Details

Returns full details for a single roadwork entry. Official docs:
https://autobahn.api.bund.dev.

## See also

[`autobahn_roadworks()`](https://mchlbckr.github.io/bunddev/reference/autobahn_roadworks.md)
to list roadworks.

## Examples

``` r
if (FALSE) { # \dontrun{
roads <- autobahn_roads()
roadworks <- autobahn_roadworks(roads$road_id[[1]])
autobahn_roadwork_details(roadworks$identifier[[1]])
} # }
```
