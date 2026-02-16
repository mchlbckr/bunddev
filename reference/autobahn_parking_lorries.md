# List Autobahn lorry parking areas

List Autobahn lorry parking areas

## Usage

``` r
autobahn_parking_lorries(road_id, flatten = FALSE, flatten_mode = "json")
```

## Arguments

- road_id:

  Road identifier.

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

A tibble with one row per lorry-parking entry. Guaranteed columns are:
`road_id`, `identifier`, `title`, `subtitle`, `display_type`, `icon`,
`is_blocked`, `future`, `start_timestamp`, `start_time`, `point`,
`extent`, `coordinate_lat`, `coordinate_long`, `description`, `footer`,
`route_recommendation` (list-column), and `lorry_parking_feature_icons`
(list-column). With `flatten = TRUE`, the two list-columns are
transformed according to `flatten_mode`.

- Scalar fields:

  One column per top-level scalar field returned by the endpoint.

- Nested fields:

  Kept as list-columns; for endpoints with `flatten` controls these can
  be transformed.

## Details

Returns lorry parking areas for a specific Autobahn road id. API
documentation: <https://autobahn.api.bund.dev>.

## See also

[`autobahn_roads()`](https://buecker.ms/bunddev/reference/autobahn_roads.md)
and
[`autobahn_parking_lorry_details()`](https://buecker.ms/bunddev/reference/autobahn_parking_lorry_details.md).

Other Autobahn:
[`autobahn_charging_station_details()`](https://buecker.ms/bunddev/reference/autobahn_charging_station_details.md),
[`autobahn_charging_stations()`](https://buecker.ms/bunddev/reference/autobahn_charging_stations.md),
[`autobahn_closure_details()`](https://buecker.ms/bunddev/reference/autobahn_closure_details.md),
[`autobahn_closures()`](https://buecker.ms/bunddev/reference/autobahn_closures.md),
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
autobahn_parking_lorries(roads$road_id[[1]], flatten = TRUE)
} # }
```
