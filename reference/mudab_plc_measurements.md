# List MUDAB PLC measurement values

List MUDAB PLC measurement values

## Usage

``` r
mudab_plc_measurements(
  filter = NULL,
  range = NULL,
  orderby = NULL,
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- filter:

  Optional filter definition.

- range:

  Optional range specification.

- orderby:

  Optional ordering specification.

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with one
row per PLC measurement and columns:

- metadataid:

  Integer. Metadata identifier.

- NUMMER:

  Integer. Running row number.

- NAME:

  Integer. Measurement name code.

- STATION_CODE:

  Character. Station code.

- STATION_NAME:

  Character. Station name.

- VALUE:

  Numeric. Measured value.

- PARAM_TYPE:

  Character. Aggregation type ("TOT" or "AVE").

- PARAM_ID:

  Character. Numeric code for NAME.

- PERIOD_NAME:

  Character. Measurement period (year).

- PERIOD_TYPE:

  Character. Aggregation duration ("A").

- LAND_CD:

  Character. Federal state code.

- ST_LAT:

  Numeric. Latitude.

- ST_LON:

  Numeric. Longitude.

- SUBCM_CODE:

  Character. Sub-compartment code.

- SUBCM_NAME:

  Character. Sub-compartment name.

- MON_TYPE:

  Character. Monitoring type.

- VAL_UNIT:

  Character. Measurement unit.

- AREA:

  Numeric. Area value.

## Details

Returns PLC station measurement values. API documentation:
<https://mudab.api.bund.dev>.

## See also

Other MUDAB:
[`mudab_parameter_values()`](https://buecker.ms/bunddev/reference/mudab_parameter_values.md),
[`mudab_parameters()`](https://buecker.ms/bunddev/reference/mudab_parameters.md),
[`mudab_parameters_biologie()`](https://buecker.ms/bunddev/reference/mudab_parameters_biologie.md),
[`mudab_parameters_biota()`](https://buecker.ms/bunddev/reference/mudab_parameters_biota.md),
[`mudab_parameters_sediment()`](https://buecker.ms/bunddev/reference/mudab_parameters_sediment.md),
[`mudab_parameters_wasser()`](https://buecker.ms/bunddev/reference/mudab_parameters_wasser.md),
[`mudab_plc_parameters()`](https://buecker.ms/bunddev/reference/mudab_plc_parameters.md),
[`mudab_plc_stations()`](https://buecker.ms/bunddev/reference/mudab_plc_stations.md),
[`mudab_project_stations()`](https://buecker.ms/bunddev/reference/mudab_project_stations.md),
[`mudab_stations()`](https://buecker.ms/bunddev/reference/mudab_stations.md)

## Examples

``` r
if (FALSE) { # \dontrun{
mudab_plc_measurements(range = list(from = 0, count = 5))
} # }
```
