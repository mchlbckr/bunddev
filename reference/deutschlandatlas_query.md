# Query Deutschlandatlas indicators

Query Deutschlandatlas indicators

## Usage

``` r
deutschlandatlas_query(
  table = "p_apo_f_ZA2022",
  params = list(),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- table:

  Table id (default "p_apo_f_ZA2022").

- params:

  Named list of ArcGIS query parameters:

  where

  :   SQL-like filter expression (required by this adapter).

  f

  :   Output format (`"json"` default).

  outFields

  :   Fields to return (`"*"` default).

  returnGeometry

  :   Whether to include geometry (`"true"`/`"false"`).

  spatialRel

  :   Spatial relation, e.g. `"esriSpatialRelIntersects"`.

  geometry

  :   Optional geometry filter (JSON string or R list).

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

A tibble with one row per ArcGIS feature. Attribute names are normalized
to lower snake_case. Includes a `geometry` list-column. Top-level scalar
API fields are returned as tibble columns; nested objects or arrays are
kept in list-columns unless the function provides `flatten` /
`flatten_mode` controls.

## Details

The Deutschlandatlas API is backed by an ArcGIS feature service. You
must supply a `where` filter and output format `f` (usually "json"). API
documentation:
<https://github.com/AndreasFischer1985/deutschlandatlas-api>.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.

## Examples

``` r
if (FALSE) { # \dontrun{
deutschlandatlas_query(
  table = "p_apo_f_ZA2022",
  params = list(
    where = "1=1",
    outFields = "*",
    f = "json",
    returnGeometry = "false",
    resultRecordCount = 5
  )
)
} # }
```
