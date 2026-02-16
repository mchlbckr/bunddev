# Get Hilfsmittel product group details

Get Hilfsmittel product group details

## Usage

``` r
hilfsmittel_produktgruppe(
  id,
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- id:

  Produktgruppe id.

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

A tibble with product group details.

## Details

Returns details for a product group (Produktgruppe). Official docs:
https://github.com/bundesAPI/hilfsmittel-api.

## Examples

``` r
if (FALSE) { # \dontrun{
tree <- hilfsmittel_tree(level = 1)
hilfsmittel_produktgruppe(tree$id[[1]])
} # }
```
