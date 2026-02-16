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

  Query parameters for the ArcGIS service.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with charging station records.

## Details

The Ladesaeulenregister API is backed by an ArcGIS feature service. You
must supply a `geometry` filter and `outFields`. The ArcGIS service may
require a `token` query parameter even though the API docs describe the
service as public. Official docs: https://ladestationen.api.bund.dev.

## See also

[`bunddev_parameters()`](https://mchlbckr.github.io/bunddev/reference/bunddev_parameters.md)
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
