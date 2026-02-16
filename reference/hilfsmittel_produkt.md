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
row for the requested product and columns:

- organisationId:

  Character. Organisation identifier.

- produktartId:

  Character. Product-type identifier.

- nummer:

  Integer. Sequential product number.

- name:

  Character. Product name.

- artikelnummern:

  List. Article numbers (character vector).

- typenAusfuehrungen:

  List. Type/model variants (character vector).

- aufnahmeDatum:

  Character. Admission date (ISO-8601).

- aenderungsDatum:

  Character. Last-modified date (ISO-8601).

- zehnSteller:

  Character. Ten-digit product code.

- herstellerName:

  Character. Manufacturer name.

- istHerausgenommen:

  Logical. Whether product is withdrawn.

- istAbrechnungsposition:

  Logical. Whether product is a billing item.

- id:

  Character. Product identifier.

- displayName:

  Character. Combined display label.

- produktgruppeNummer:

  Integer. Product-group number.

- anwendungsortNummer:

  Integer. Application-site number.

- untergruppeNummer:

  Integer. Subgroup number.

- produktartNummer:

  Integer. Product-type number.

- produktartBezeichnung:

  Character. Product-type name.

- kontruktionsmerkmale:

  List. Construction features (nested objects).

- aufnahmeDatum_time:

  POSIXct. Parsed admission date (Europe/Berlin).

- aenderungsDatum_time:

  POSIXct. Parsed last-modified date (Europe/Berlin).

## Details

Returns detail information for a single product. API documentation:
<https://github.com/bundesAPI/hilfsmittel-api>.

## See also

Other Hilfsmittel:
[`hilfsmittel_nachweisschema()`](https://buecker.ms/bunddev/reference/hilfsmittel_nachweisschema.md),
[`hilfsmittel_produktart()`](https://buecker.ms/bunddev/reference/hilfsmittel_produktart.md),
[`hilfsmittel_produkte()`](https://buecker.ms/bunddev/reference/hilfsmittel_produkte.md),
[`hilfsmittel_produktgruppe()`](https://buecker.ms/bunddev/reference/hilfsmittel_produktgruppe.md),
[`hilfsmittel_tree()`](https://buecker.ms/bunddev/reference/hilfsmittel_tree.md),
[`hilfsmittel_untergruppe()`](https://buecker.ms/bunddev/reference/hilfsmittel_untergruppe.md)

## Examples

``` r
if (FALSE) { # \dontrun{
hilfsmittel_produkt("f41f52a6-5d2d-4dd3-9d0e-39675ceca7f3")
} # }
```
