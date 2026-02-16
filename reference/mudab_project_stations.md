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

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with project stations.

## Details

Returns project stations from the MUDAB database. Official docs:
https://mudab.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
mudab_project_stations(range = list(from = 0, count = 5))
} # }
```
