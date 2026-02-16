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
row for the requested product type and columns:

- id:

  Character. Product-type identifier.

- versionId:

  Character. Internal version identifier.

- nummer:

  Integer. Product-type number.

- beschreibung:

  Character. Description text.

- bezeichnung:

  Character. Product-type name.

- untergruppeId:

  Character. Parent subgroup identifier.

- indikation:

  Character. Indication text.

- siebenSteller:

  Character. Seven-digit code.

- isNnElement:

  Logical. Internal flag (usage unclear).

- konstruktionsmerkmalschemaId:

  Character. Construction-feature schema id.

- untergruppe:

  Integer. Always `NA`.

- aufnahmeDatum:

  Character. Admission date (ISO-8601).

- aenderungsDatum:

  Character. Last-modified date (ISO-8601).

- aufnahmeDatum_time:

  POSIXct. Parsed admission date (Europe/Berlin).

- aenderungsDatum_time:

  POSIXct. Parsed last-modified date (Europe/Berlin).

## Details

Returns details for a product type (Produktart). API documentation:
<https://github.com/bundesAPI/hilfsmittel-api>.

## See also

Other Hilfsmittel:
[`hilfsmittel_nachweisschema()`](https://buecker.ms/bunddev/reference/hilfsmittel_nachweisschema.md),
[`hilfsmittel_produkt()`](https://buecker.ms/bunddev/reference/hilfsmittel_produkt.md),
[`hilfsmittel_produkte()`](https://buecker.ms/bunddev/reference/hilfsmittel_produkte.md),
[`hilfsmittel_produktgruppe()`](https://buecker.ms/bunddev/reference/hilfsmittel_produktgruppe.md),
[`hilfsmittel_tree()`](https://buecker.ms/bunddev/reference/hilfsmittel_tree.md),
[`hilfsmittel_untergruppe()`](https://buecker.ms/bunddev/reference/hilfsmittel_untergruppe.md)

## Examples

``` r
if (FALSE) { # \dontrun{
hilfsmittel_produktart("e6b913ef-cf21-4c5f-826d-f866516c3c65")
} # }
```
