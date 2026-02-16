# List MUDAB project stations

List MUDAB project stations

## Usage

``` r
mudab_project_stations(
  filter = NULL,
  range = NULL,
  orderby = NULL,
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
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

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with one
row per project station and columns:

- metadataid:

  Integer. Metadata identifier.

- PROJECTSTATIONID:

  Integer. Project station identifier.

- NAME_PS:

  Character. Project station name.

- REGION:

  Character. Region of the station.

- INSTITUT:

  Character. Responsible institute.

## Details

Returns project stations from the MUDAB database. API documentation:
<https://mudab.api.bund.dev>.

## See also

Other MUDAB:
[`mudab_parameter_values()`](https://buecker.ms/bunddev/reference/mudab_parameter_values.md),
[`mudab_parameters()`](https://buecker.ms/bunddev/reference/mudab_parameters.md),
[`mudab_parameters_biologie()`](https://buecker.ms/bunddev/reference/mudab_parameters_biologie.md),
[`mudab_parameters_biota()`](https://buecker.ms/bunddev/reference/mudab_parameters_biota.md),
[`mudab_parameters_sediment()`](https://buecker.ms/bunddev/reference/mudab_parameters_sediment.md),
[`mudab_parameters_wasser()`](https://buecker.ms/bunddev/reference/mudab_parameters_wasser.md),
[`mudab_plc_measurements()`](https://buecker.ms/bunddev/reference/mudab_plc_measurements.md),
[`mudab_plc_parameters()`](https://buecker.ms/bunddev/reference/mudab_plc_parameters.md),
[`mudab_plc_stations()`](https://buecker.ms/bunddev/reference/mudab_plc_stations.md),
[`mudab_stations()`](https://buecker.ms/bunddev/reference/mudab_stations.md)

## Examples

``` r
if (FALSE) { # \dontrun{
mudab_project_stations(range = list(from = 0, count = 5))
} # }
```
