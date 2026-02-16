# List MaStR filter options for electricity consumption

List MaStR filter options for electricity consumption

## Usage

``` r
marktstammdaten_filters_stromverbrauch(
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

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

A tibble with filter metadata.

## Details

Returns filter definitions for public electricity consumption data.
Official docs: https://github.com/bundesAPI/marktstammdaten-api.

## Examples

``` r
if (FALSE) { # \dontrun{
marktstammdaten_filters_stromverbrauch()
} # }
```
