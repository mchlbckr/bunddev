# Get Hilfsmittel product details

Get Hilfsmittel product details

## Usage

``` r
hilfsmittel_produkt(
  id,
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- id:

  Produkt id.

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

A tibble with product details.

## Details

Returns detail information for a single product. Official docs:
https://github.com/bundesAPI/hilfsmittel-api.

## Examples

``` r
if (FALSE) { # \dontrun{
hilfsmittel_produkt("f41f52a6-5d2d-4dd3-9d0e-39675ceca7f3")
} # }
```
