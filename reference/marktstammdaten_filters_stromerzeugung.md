# List MaStR filter options for electricity generation

List MaStR filter options for electricity generation

## Usage

``` r
marktstammdaten_filters_stromerzeugung(
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

Returns filter definitions for public electricity generation data.
Official docs: https://github.com/bundesAPI/marktstammdaten-api.

## Examples

``` r
if (FALSE) { # \dontrun{
marktstammdaten_filters_stromerzeugung()
} # }
```
