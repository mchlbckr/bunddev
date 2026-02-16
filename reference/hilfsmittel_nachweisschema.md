# Get Hilfsmittel verification schema details

Get Hilfsmittel verification schema details

## Usage

``` r
hilfsmittel_nachweisschema(
  id,
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- id:

  Nachweisschema id.

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

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with one
row for the requested verification schema and columns:

- id:

  Character. Schema identifier.

- name:

  Character. Schema name.

- produktmusterErforderlich:

  Logical. Whether a product sample is required.

- nachweisschemaKategorieZuweisungen:

  List. Category assignments (nested objects).

- nachweisAbschnittAnforderungen:

  List. Section requirements (nested objects).

## Details

Returns detail information for a Nachweisschema. API documentation:
<https://github.com/bundesAPI/hilfsmittel-api>.

## See also

Other Hilfsmittel:
[`hilfsmittel_produkt()`](https://buecker.ms/bunddev/reference/hilfsmittel_produkt.md),
[`hilfsmittel_produktart()`](https://buecker.ms/bunddev/reference/hilfsmittel_produktart.md),
[`hilfsmittel_produkte()`](https://buecker.ms/bunddev/reference/hilfsmittel_produkte.md),
[`hilfsmittel_produktgruppe()`](https://buecker.ms/bunddev/reference/hilfsmittel_produktgruppe.md),
[`hilfsmittel_tree()`](https://buecker.ms/bunddev/reference/hilfsmittel_tree.md),
[`hilfsmittel_untergruppe()`](https://buecker.ms/bunddev/reference/hilfsmittel_untergruppe.md)

## Examples

``` r
if (FALSE) { # \dontrun{
hilfsmittel_nachweisschema("a3d37017-2c91-4d6d-bbbe-4002d2868044")
} # }
```
