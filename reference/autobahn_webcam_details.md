# Get Autobahn webcam details

Get Autobahn webcam details

## Usage

``` r
autobahn_webcam_details(webcam_id, flatten = FALSE, flatten_mode = "json")
```

## Arguments

- webcam_id:

  Webcam identifier.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with webcam details.

## Details

Returns full details for a single webcam entry. Official docs:
https://autobahn.api.bund.dev.

## See also

[`autobahn_webcams()`](https://mchlbckr.github.io/bunddev/reference/autobahn_webcams.md)
to list webcams.

## Examples

``` r
if (FALSE) { # \dontrun{
roads <- autobahn_roads()
webcams <- autobahn_webcams(roads$road_id[[1]])
autobahn_webcam_details(webcams$identifier[[1]])
} # }
```
