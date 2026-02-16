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

A tibble with indicator records.

## Details

The Deutschlandatlas API is backed by an ArcGIS feature service. You
must supply a `where` filter and output format `f` (usually "json").
Official docs:
https://github.com/AndreasFischer1985/deutschlandatlas-api.

## See also

[`bunddev_parameters()`](https://mchlbckr.github.io/bunddev/reference/bunddev_parameters.md)
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
