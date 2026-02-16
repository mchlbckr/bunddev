# Query charging stations

Query charging stations

## Usage

``` r
ladestationen_query(
  params = list(),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- params:

  Named list of ArcGIS query parameters. Common keys:

  geometry

  :   Geometry filter (required by this adapter). Can be a JSON string
      or an R list that is converted to JSON.

  geometryType

  :   Geometry type, e.g. `"esriGeometryEnvelope"`.

  where

  :   SQL-like filter expression (default often `"1=1"`).

  outFields

  :   Fields to return (default `"*"`).

  returnGeometry

  :   Whether to include feature geometry (`"true"`/`"false"`).

  outSR

  :   Output spatial reference id, e.g. `4326`.

  f

  :   Output format (default `"json"`).

  resultRecordCount

  :   Maximum number of returned rows (integer).

  token

  :   Optional ArcGIS access token if required by upstream service.

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
to lower snake_case. Includes a `geometry` list-column with the feature
geometry object.

- Attribute columns:

  One column per ArcGIS `attributes` field (normalized to snake_case).

- geometry:

  Feature geometry object as list-column.

## Details

The Ladesaeulenregister API is backed by an ArcGIS feature service. You
must supply a `geometry` filter and `outFields`. The ArcGIS service may
require a `token` query parameter even though the API docs describe the
service as public. API documentation:
<https://ladestationen.api.bund.dev>.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.

## Examples

``` r
if (FALSE) { # \dontrun{
geometry <- jsonlite::toJSON(
  list(
    xmin = 13.3, ymin = 52.4, xmax = 13.5, ymax = 52.6,
    spatialReference = list(wkid = 4326)
  ),
  auto_unbox = TRUE
)
ladestationen_query(params = list(
  geometry = geometry,
  geometryType = "esriGeometryEnvelope",
  where = "1=1",
  outFields = "*",
  outSR = 4326,
  f = "json",
  returnGeometry = "false",
  resultRecordCount = 5
))
} # }
```
