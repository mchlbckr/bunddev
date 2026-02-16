# List Autobahn road ids

List Autobahn road ids

## Usage

``` r
autobahn_roads()
```

## Value

A tibble with one row per Autobahn id and column `road_id`.

Guaranteed column is `road_id` (character), one row per Autobahn
identifier.

## Details

Lists Autobahn road ids from the Autobahn App API (Autobahn GmbH). API
documentation: <https://autobahn.api.bund.dev>.

## See also

[`autobahn_roadworks()`](https://buecker.ms/bunddev/reference/autobahn_roadworks.md)
and
[`autobahn_warnings()`](https://buecker.ms/bunddev/reference/autobahn_warnings.md)
for road-specific data.

Other Autobahn:
[`autobahn_charging_station_details()`](https://buecker.ms/bunddev/reference/autobahn_charging_station_details.md),
[`autobahn_charging_stations()`](https://buecker.ms/bunddev/reference/autobahn_charging_stations.md),
[`autobahn_closure_details()`](https://buecker.ms/bunddev/reference/autobahn_closure_details.md),
[`autobahn_closures()`](https://buecker.ms/bunddev/reference/autobahn_closures.md),
[`autobahn_parking_lorries()`](https://buecker.ms/bunddev/reference/autobahn_parking_lorries.md),
[`autobahn_parking_lorry_details()`](https://buecker.ms/bunddev/reference/autobahn_parking_lorry_details.md),
[`autobahn_roadwork_details()`](https://buecker.ms/bunddev/reference/autobahn_roadwork_details.md),
[`autobahn_roadworks()`](https://buecker.ms/bunddev/reference/autobahn_roadworks.md),
[`autobahn_warning_details()`](https://buecker.ms/bunddev/reference/autobahn_warning_details.md),
[`autobahn_warnings()`](https://buecker.ms/bunddev/reference/autobahn_warnings.md),
[`autobahn_webcam_details()`](https://buecker.ms/bunddev/reference/autobahn_webcam_details.md),
[`autobahn_webcams()`](https://buecker.ms/bunddev/reference/autobahn_webcams.md)

## Examples

``` r
if (FALSE) { # \dontrun{
autobahn_roads()
} # }
```
