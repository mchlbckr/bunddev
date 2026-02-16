# List MUDAB parameters (Sediment)

List MUDAB parameters (Sediment)

## Usage

``` r
mudab_parameters_sediment(
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

A tibble with one row per returned `MV_PARAMETER_SEDIMENT` record.

- Record fields:

  One column per top-level scalar field of the selected MUDAB record
  type.

- Nested fields:

  Stored as list-columns.

- datetime_time:

  Added as `POSIXct` (Europe/Berlin) when `DATE_STM` and `TIME_STM`
  exist.

## Details

Returns parameter entries for the Sediment compartment. API
documentation: <https://mudab.api.bund.dev>.

## See also

Other MUDAB:
[`mudab_parameter_values()`](https://buecker.ms/bunddev/reference/mudab_parameter_values.md),
[`mudab_parameters()`](https://buecker.ms/bunddev/reference/mudab_parameters.md),
[`mudab_parameters_biologie()`](https://buecker.ms/bunddev/reference/mudab_parameters_biologie.md),
[`mudab_parameters_biota()`](https://buecker.ms/bunddev/reference/mudab_parameters_biota.md),
[`mudab_parameters_wasser()`](https://buecker.ms/bunddev/reference/mudab_parameters_wasser.md),
[`mudab_plc_measurements()`](https://buecker.ms/bunddev/reference/mudab_plc_measurements.md),
[`mudab_plc_parameters()`](https://buecker.ms/bunddev/reference/mudab_plc_parameters.md),
[`mudab_plc_stations()`](https://buecker.ms/bunddev/reference/mudab_plc_stations.md),
[`mudab_project_stations()`](https://buecker.ms/bunddev/reference/mudab_project_stations.md),
[`mudab_stations()`](https://buecker.ms/bunddev/reference/mudab_stations.md)

## Examples

``` r
if (FALSE) { # \dontrun{
mudab_parameters_sediment(range = list(from = 0, count = 5))
} # }
```
