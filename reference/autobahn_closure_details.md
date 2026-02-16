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

A one-row tibble with detailed fields for the selected closure.

## Details

Returns full details for a single closure entry. API documentation:
<https://autobahn.api.bund.dev>.

## See also

[`autobahn_closures()`](https://buecker.ms/bunddev/reference/autobahn_closures.md)
to list closures.

Other Autobahn:
[`autobahn_charging_station_details()`](https://buecker.ms/bunddev/reference/autobahn_charging_station_details.md),
[`autobahn_charging_stations()`](https://buecker.ms/bunddev/reference/autobahn_charging_stations.md),
[`autobahn_closures()`](https://buecker.ms/bunddev/reference/autobahn_closures.md),
[`autobahn_parking_lorries()`](https://buecker.ms/bunddev/reference/autobahn_parking_lorries.md),
[`autobahn_parking_lorry_details()`](https://buecker.ms/bunddev/reference/autobahn_parking_lorry_details.md),
[`autobahn_roads()`](https://buecker.ms/bunddev/reference/autobahn_roads.md),
[`autobahn_roadwork_details()`](https://buecker.ms/bunddev/reference/autobahn_roadwork_details.md),
[`autobahn_roadworks()`](https://buecker.ms/bunddev/reference/autobahn_roadworks.md),
[`autobahn_warning_details()`](https://buecker.ms/bunddev/reference/autobahn_warning_details.md),
[`autobahn_warnings()`](https://buecker.ms/bunddev/reference/autobahn_warnings.md),
[`autobahn_webcam_details()`](https://buecker.ms/bunddev/reference/autobahn_webcam_details.md),
[`autobahn_webcams()`](https://buecker.ms/bunddev/reference/autobahn_webcams.md)

## Examples

``` r
if (FALSE) { # \dontrun{
roads <- autobahn_roads()
closures <- autobahn_closures(roads$road_id[[1]])
autobahn_closure_details(closures$identifier[[1]])
} # }
```
