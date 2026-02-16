# List MUDAB parameter values

List MUDAB parameter values

## Usage

``` r
mudab_parameter_values(
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
row per measurement value and columns:

- metadataid:

  Integer. Metadata identifier.

- STATNAME_ST:

  Character. Station name.

- STATNAME_DATE_TIME:

  Character. Composite station-date-time string.

- PARAMETERID_PM:

  Character. Parameter identifier.

- PARAMCODE_PM:

  Character. Parameter code name.

- DATE_STM:

  Character. Measurement date (YYYYMMDD).

- TIME_STM:

  Character. Measurement time (HHMM).

- VALUE_MS:

  Character. Measured value.

- datetime_time:

  POSIXct. Parsed date-time (Europe/Berlin).

## Details

Returns measurement values for parameters from the MUDAB database. API
documentation: <https://mudab.api.bund.dev>.

## See also

Other MUDAB:
[`mudab_parameters()`](https://buecker.ms/bunddev/reference/mudab_parameters.md),
[`mudab_parameters_biologie()`](https://buecker.ms/bunddev/reference/mudab_parameters_biologie.md),
[`mudab_parameters_biota()`](https://buecker.ms/bunddev/reference/mudab_parameters_biota.md),
[`mudab_parameters_sediment()`](https://buecker.ms/bunddev/reference/mudab_parameters_sediment.md),
[`mudab_parameters_wasser()`](https://buecker.ms/bunddev/reference/mudab_parameters_wasser.md),
[`mudab_plc_measurements()`](https://buecker.ms/bunddev/reference/mudab_plc_measurements.md),
[`mudab_plc_parameters()`](https://buecker.ms/bunddev/reference/mudab_plc_parameters.md),
[`mudab_plc_stations()`](https://buecker.ms/bunddev/reference/mudab_plc_stations.md),
[`mudab_project_stations()`](https://buecker.ms/bunddev/reference/mudab_project_stations.md),
[`mudab_stations()`](https://buecker.ms/bunddev/reference/mudab_stations.md)

## Examples

``` r
if (FALSE) { # \dontrun{
mudab_parameter_values(range = list(from = 0, count = 5))
} # }
```
