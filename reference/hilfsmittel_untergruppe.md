# Get Hilfsmittel subgroup details

Get Hilfsmittel subgroup details

## Usage

``` r
hilfsmittel_untergruppe(
  id,
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- id:

  Untergruppe id.

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

- flatten:

  Logical; if `TRUE`, simplify nested list columns according to
  `flatten_mode`. Default `FALSE` keeps list columns as-is.

- flatten_mode:

  How to handle list columns when `flatten = TRUE`:

  `"drop"`

  :   Remove list columns entirely. Use when nested data is not needed.

  `"json"`

  :   Convert each list element to a JSON string. Preserves all data in
      a text-queryable format. This is the **default**.

  `"unnest"`

  :   Expand list columns into multiple rows via
      [`tidyr::unnest_longer()`](https://tidyr.tidyverse.org/reference/unnest_longer.html).
      **Warning:** this can significantly increase the number of rows.

## Value

A tibble with detail fields for one subgroup. Columns follow upstream
schema; nested values may appear as list-columns.

- Scalar fields:

  One column per top-level scalar field returned by the endpoint.

- Nested fields:

  Kept as list-columns; for endpoints with `flatten` controls these can
  be transformed.

## Details

Returns details for a subgroup (Untergruppe). API documentation:
<https://github.com/bundesAPI/hilfsmittel-api>.

## See also

Other Hilfsmittel:
[`hilfsmittel_nachweisschema()`](https://buecker.ms/bunddev/reference/hilfsmittel_nachweisschema.md),
[`hilfsmittel_produkt()`](https://buecker.ms/bunddev/reference/hilfsmittel_produkt.md),
[`hilfsmittel_produktart()`](https://buecker.ms/bunddev/reference/hilfsmittel_produktart.md),
[`hilfsmittel_produkte()`](https://buecker.ms/bunddev/reference/hilfsmittel_produkte.md),
[`hilfsmittel_produktgruppe()`](https://buecker.ms/bunddev/reference/hilfsmittel_produktgruppe.md),
[`hilfsmittel_tree()`](https://buecker.ms/bunddev/reference/hilfsmittel_tree.md)

## Examples

``` r
if (FALSE) { # \dontrun{
hilfsmittel_untergruppe("c92d1976-d3cb-4b9f-bcdf-805272a9ea86")
} # }
```
