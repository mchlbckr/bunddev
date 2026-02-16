# Get Hilfsmittel product type details

Get Hilfsmittel product type details

## Usage

``` r
hilfsmittel_produktart(
  id,
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- id:

  Produktart id.

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

A tibble with product type details.

## Details

Returns details for a product type (Produktart). Official docs:
https://github.com/bundesAPI/hilfsmittel-api.

## Examples

``` r
if (FALSE) { # \dontrun{
hilfsmittel_produktart("e6b913ef-cf21-4c5f-826d-f866516c3c65")
} # }
```
