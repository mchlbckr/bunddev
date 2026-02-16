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

A tibble with one row per warning entry:

- road_id:

  Road identifier (character).

- identifier:

  Entry identifier (character).

- title:

  Title (character).

- subtitle:

  Subtitle (character).

- display_type:

  Display type (character).

- icon:

  Icon identifier (character).

- is_blocked:

  Whether the road is blocked (logical).

- future:

  Whether the entry is future-dated (logical).

- start_timestamp:

  Start timestamp string (character).

- start_time:

  Parsed start time (POSIXct).

- point:

  Point coordinate string (character).

- extent:

  Extent coordinate string (character).

- coordinate_lat:

  Latitude (character).

- coordinate_long:

  Longitude (character).

- description:

  Description text (character).

- footer:

  Footer text (character).

- route_recommendation:

  Route recommendations (list-column).

- lorry_parking_feature_icons:

  Lorry parking feature icons (list-column).

With `flatten = TRUE`, the two list-columns are transformed according to
`flatten_mode`.

## Details

Returns current warnings for a specific Autobahn road id. API
documentation: <https://autobahn.api.bund.dev>.

## See also

[`autobahn_roads()`](https://buecker.ms/bunddev/reference/autobahn_roads.md)
to list roads and
[`autobahn_warning_details()`](https://buecker.ms/bunddev/reference/autobahn_warning_details.md)
for details.

Other Autobahn:
[`autobahn_charging_station_details()`](https://buecker.ms/bunddev/reference/autobahn_charging_station_details.md),
[`autobahn_charging_stations()`](https://buecker.ms/bunddev/reference/autobahn_charging_stations.md),
[`autobahn_closure_details()`](https://buecker.ms/bunddev/reference/autobahn_closure_details.md),
[`autobahn_closures()`](https://buecker.ms/bunddev/reference/autobahn_closures.md),
[`autobahn_parking_lorries()`](https://buecker.ms/bunddev/reference/autobahn_parking_lorries.md),
[`autobahn_parking_lorry_details()`](https://buecker.ms/bunddev/reference/autobahn_parking_lorry_details.md),
[`autobahn_roads()`](https://buecker.ms/bunddev/reference/autobahn_roads.md),
[`autobahn_roadwork_details()`](https://buecker.ms/bunddev/reference/autobahn_roadwork_details.md),
[`autobahn_roadworks()`](https://buecker.ms/bunddev/reference/autobahn_roadworks.md),
[`autobahn_warning_details()`](https://buecker.ms/bunddev/reference/autobahn_warning_details.md),
[`autobahn_webcam_details()`](https://buecker.ms/bunddev/reference/autobahn_webcam_details.md),
[`autobahn_webcams()`](https://buecker.ms/bunddev/reference/autobahn_webcams.md)

## Examples

``` r
if (FALSE) { # \dontrun{
roads <- autobahn_roads()
autobahn_warnings(roads$road_id[[1]], flatten = TRUE)
} # }
```
