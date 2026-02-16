# List DiGA device definitions

List DiGA device definitions

## Usage

``` r
diga_device_definitions(
  params = list(),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- params:

  Query parameters.

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

A tibble containing DiGA device definitions from the FHIR API. When
`flatten = FALSE`, nested FHIR resource elements are preserved as list
columns. When `flatten = TRUE`, list columns are expanded based on the
specified `flatten_mode`.

## Examples

``` r
if (FALSE) dig_device_definitions() # \dontrun{}
```
