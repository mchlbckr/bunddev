# List MUDAB parameters

List MUDAB parameters

## Usage

``` r
mudab_parameters(
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

A tibble with one row per returned `MV_PARAMETER` record. Top-level
scalar API fields are returned as tibble columns; nested objects or
arrays are kept in list-columns unless the function provides `flatten` /
`flatten_mode` controls.

## Details

Returns measurement parameters from the MUDAB database. API
documentation: <https://mudab.api.bund.dev>.

## See also

Other MUDAB:
[`mudab_parameter_values()`](https://buecker.ms/bunddev/reference/mudab_parameter_values.md),
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
mudab_parameters(range = list(from = 0, count = 5))
} # }
```
