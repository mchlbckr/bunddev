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

  Logical; if `TRUE`, simplify nested list columns according to
  `flatten_mode`. Default `FALSE` keeps list columns as-is.

- flatten_mode:

  How to handle list columns when `flatten = TRUE`:

  `"drop"`

  :   Remove list columns entirely. Use when nested data is not needed.

  `"json"`

  :   Convert each list element to a JSON string. Preserves all data in
      a text-queryable format. This is the **default**.

  `"unnest"`

  :   Expand list columns into multiple rows via
      [`tidyr::unnest_longer()`](https://tidyr.tidyverse.org/reference/unnest_longer.html).
      **Warning:** this can significantly increase the number of rows.

## Value

A one-row tibble for the selected roadwork with the same columns as
[`autobahn_roadworks()`](https://buecker.ms/bunddev/reference/autobahn_roadworks.md).
`road_id` is typically `NA` for detail calls.

## Details

Returns full details for a single roadwork entry. API documentation:
<https://autobahn.api.bund.dev>.

## See also

[`autobahn_roadworks()`](https://buecker.ms/bunddev/reference/autobahn_roadworks.md)
to list roadworks.

Other Autobahn:
[`autobahn_charging_station_details()`](https://buecker.ms/bunddev/reference/autobahn_charging_station_details.md),
[`autobahn_charging_stations()`](https://buecker.ms/bunddev/reference/autobahn_charging_stations.md),
[`autobahn_closure_details()`](https://buecker.ms/bunddev/reference/autobahn_closure_details.md),
[`autobahn_closures()`](https://buecker.ms/bunddev/reference/autobahn_closures.md),
[`autobahn_parking_lorries()`](https://buecker.ms/bunddev/reference/autobahn_parking_lorries.md),
[`autobahn_parking_lorry_details()`](https://buecker.ms/bunddev/reference/autobahn_parking_lorry_details.md),
[`autobahn_roads()`](https://buecker.ms/bunddev/reference/autobahn_roads.md),
[`autobahn_roadworks()`](https://buecker.ms/bunddev/reference/autobahn_roadworks.md),
[`autobahn_warning_details()`](https://buecker.ms/bunddev/reference/autobahn_warning_details.md),
[`autobahn_warnings()`](https://buecker.ms/bunddev/reference/autobahn_warnings.md),
[`autobahn_webcam_details()`](https://buecker.ms/bunddev/reference/autobahn_webcam_details.md),
[`autobahn_webcams()`](https://buecker.ms/bunddev/reference/autobahn_webcams.md)

## Examples

``` r
if (FALSE) { # \dontrun{
roads <- autobahn_roads()
roadworks <- autobahn_roadworks(roads$road_id[[1]])
autobahn_roadwork_details(roadworks$identifier[[1]])
} # }
```
