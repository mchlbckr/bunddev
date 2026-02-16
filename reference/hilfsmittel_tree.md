# List Hilfsmittel tree nodes

List Hilfsmittel tree nodes

## Usage

``` r
hilfsmittel_tree(level, safe = TRUE, refresh = FALSE)
```

## Arguments

- level:

  Tree level to retrieve (1-4).

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with one
row per tree node and columns:

- id:

  Character. Node identifier.

- parentId:

  Character. Parent node identifier (`NA` for roots).

- displayValue:

  Character. Node display label.

- xStellerDisplayValue:

  Character. xSteller with label.

- xSteller:

  Character. Position code of the node.

- level:

  Integer. Tree depth level.

## Details

Returns nodes from the Hilfsmittel product tree up to the selected
level. API documentation:
<https://github.com/bundesAPI/hilfsmittel-api>.

## See also

Other Hilfsmittel:
[`hilfsmittel_nachweisschema()`](https://buecker.ms/bunddev/reference/hilfsmittel_nachweisschema.md),
[`hilfsmittel_produkt()`](https://buecker.ms/bunddev/reference/hilfsmittel_produkt.md),
[`hilfsmittel_produktart()`](https://buecker.ms/bunddev/reference/hilfsmittel_produktart.md),
[`hilfsmittel_produkte()`](https://buecker.ms/bunddev/reference/hilfsmittel_produkte.md),
[`hilfsmittel_produktgruppe()`](https://buecker.ms/bunddev/reference/hilfsmittel_produktgruppe.md),
[`hilfsmittel_untergruppe()`](https://buecker.ms/bunddev/reference/hilfsmittel_untergruppe.md)

## Examples

``` r
if (FALSE) { # \dontrun{
hilfsmittel_tree(level = 1)
} # }
```
