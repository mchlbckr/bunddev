# List Hilfsmittel products

List Hilfsmittel products

## Usage

``` r
hilfsmittel_produkte(
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

A tibble with products.

## Details

Returns the full product list (large payload). Official docs:
https://github.com/bundesAPI/hilfsmittel-api.

## Examples

``` r
if (FALSE) { # \dontrun{
hilfsmittel_produkte()
} # }
```
