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
row for the requested product group and columns:

- id:

  Character. Product group identifier.

- versionId:

  Character. Internal version identifier.

- bezeichnung:

  Character. Product group name.

- nummer:

  Integer. Product group number.

- definition:

  Character. Description text.

- indikation:

  Character. Indication text.

- querverweis:

  Character. Cross-reference to other groups.

- isNnElement:

  Logical. Internal flag (usage unclear).

- sachbearbeiterGkvId:

  Character. GKV case-worker identifier.

- sachbearbeiterGkv:

  Character. Always `NA`.

- sachbearbeiterMdsId:

  Character. MDS case-worker identifier.

- sachbearbeiterMds:

  Character. Always `NA`.

- aufnahmeDatum:

  Character. Admission date (ISO-8601).

- aenderungsDatum:

  Character. Last-modified date (ISO-8601).

- veroeffentlichungsDokumentFileStoreId:

  Character. Publication document id.

- merkblattFileStoreId:

  Character. Always `NA`.

- isCollectionReviewable:

  Logical. Internal flag (usage unclear).

- aufnahmeDatum_time:

  POSIXct. Parsed admission date (Europe/Berlin).

- aenderungsDatum_time:

  POSIXct. Parsed last-modified date (Europe/Berlin).

## Details

Returns details for a product group (Produktgruppe). API documentation:
<https://github.com/bundesAPI/hilfsmittel-api>.

## See also

Other Hilfsmittel:
[`hilfsmittel_nachweisschema()`](https://buecker.ms/bunddev/reference/hilfsmittel_nachweisschema.md),
[`hilfsmittel_produkt()`](https://buecker.ms/bunddev/reference/hilfsmittel_produkt.md),
[`hilfsmittel_produktart()`](https://buecker.ms/bunddev/reference/hilfsmittel_produktart.md),
[`hilfsmittel_produkte()`](https://buecker.ms/bunddev/reference/hilfsmittel_produkte.md),
[`hilfsmittel_tree()`](https://buecker.ms/bunddev/reference/hilfsmittel_tree.md),
[`hilfsmittel_untergruppe()`](https://buecker.ms/bunddev/reference/hilfsmittel_untergruppe.md)

## Examples

``` r
if (FALSE) { # \dontrun{
tree <- hilfsmittel_tree(level = 1)
hilfsmittel_produktgruppe(tree$id[[1]])
} # }
```
