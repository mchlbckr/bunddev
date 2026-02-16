# List MUDAB parameters (Wasser)

List MUDAB parameters (Wasser)

## Usage

``` r
mudab_parameters_wasser(
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
row per parameter and columns:

- metadataid:

  Integer. Metadata identifier.

- COMPT_DS:

  Character. Compartment code (BL, CW, CS, or CF).

- PARAMETER:

  Character. Parameter abbreviation.

- PARAMETERGRUPPE:

  Character. Parameter group code.

- PARAM_NAME:

  Character. Parameter name.

- PARGROUP:

  Character. Parameter group code (alternate).

- PARAMGROUP_NAME:

  Character. Parameter group name.

## Details

Returns parameter entries for the Wasser compartment. API documentation:
<https://mudab.api.bund.dev>.

## See also

Other MUDAB:
[`mudab_parameter_values()`](https://buecker.ms/bunddev/reference/mudab_parameter_values.md),
[`mudab_parameters()`](https://buecker.ms/bunddev/reference/mudab_parameters.md),
[`mudab_parameters_biologie()`](https://buecker.ms/bunddev/reference/mudab_parameters_biologie.md),
[`mudab_parameters_biota()`](https://buecker.ms/bunddev/reference/mudab_parameters_biota.md),
[`mudab_parameters_sediment()`](https://buecker.ms/bunddev/reference/mudab_parameters_sediment.md),
[`mudab_plc_measurements()`](https://buecker.ms/bunddev/reference/mudab_plc_measurements.md),
[`mudab_plc_parameters()`](https://buecker.ms/bunddev/reference/mudab_plc_parameters.md),
[`mudab_plc_stations()`](https://buecker.ms/bunddev/reference/mudab_plc_stations.md),
[`mudab_project_stations()`](https://buecker.ms/bunddev/reference/mudab_project_stations.md),
[`mudab_stations()`](https://buecker.ms/bunddev/reference/mudab_stations.md)

## Examples

``` r
if (FALSE) { # \dontrun{
mudab_parameters_wasser(range = list(from = 0, count = 5))
} # }
```
