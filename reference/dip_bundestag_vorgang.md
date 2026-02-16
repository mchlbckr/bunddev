# Get a DIP Vorgang

Get a DIP Vorgang

## Usage

``` r
dip_bundestag_vorgang(
  vorgang_id,
  params = list(),
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- vorgang_id:

  Vorgang id.

- params:

  Named list of query parameters. Common keys:

  format

  :   Response format (`"json"` recommended; default set by adapter).

  apikey

  :   Optional API key as query parameter (prefer auth header).

  fuzzy

  :   Free-text search string (character).

  sort

  :   Sort field/order definition (character).

  cursor

  :   Cursor for pagination (character).

  limit

  :   Page size/maximum number of documents (integer).

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A one-row tibble for the selected Vorgang:

- id:

  Vorgang identifier (character).

- typ:

  Entity type, always `"Vorgang"` (character).

- beratungsstand:

  Consultation status, e.g. `"Abgeschlossen"` (character).

- vorgangstyp:

  Vorgang type, e.g. `"Geschäftsordnung"` (character).

- wahlperiode:

  Legislative period (integer).

- initiative:

  Initiating factions/bodies (list-column).

- datum:

  Date of most recent associated document (character, ISO date).

- aktualisiert:

  Last update timestamp (character, ISO datetime).

- titel:

  Title (character).

- abstract:

  Summary text (character or `NA`).

- sachgebiet:

  Subject areas (list-column).

- deskriptor:

  Thesaurus descriptors (list-column of named lists).

- gesta:

  GESTA reference number (character or `NA`).

- zustimmungsbeduerftigkeit:

  Consent requirements (list-column).

- kom:

  EU COM reference number (character or `NA`).

- ratsdok:

  EU Council document number (character or `NA`).

- verkuendung:

  Promulgation details (list-column).

- inkrafttreten:

  Entry-into-force details (list-column).

- archiv:

  Archive reference (character or `NA`).

- mitteilung:

  Supplementary note (character or `NA`).

- vorgang_verlinkung:

  Linked Vorgänge (list-column).

- sek:

  EU SEC reference number (character or `NA`).

## Details

Returns metadata for a single Vorgang.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.

Other DIP Bundestag:
[`dip_bundestag_aktivitaet()`](https://buecker.ms/bunddev/reference/dip_bundestag_aktivitaet.md),
[`dip_bundestag_aktivitaet_list()`](https://buecker.ms/bunddev/reference/dip_bundestag_aktivitaet_list.md),
[`dip_bundestag_drucksache()`](https://buecker.ms/bunddev/reference/dip_bundestag_drucksache.md),
[`dip_bundestag_drucksache_list()`](https://buecker.ms/bunddev/reference/dip_bundestag_drucksache_list.md),
[`dip_bundestag_drucksache_text()`](https://buecker.ms/bunddev/reference/dip_bundestag_drucksache_text.md),
[`dip_bundestag_drucksache_text_list()`](https://buecker.ms/bunddev/reference/dip_bundestag_drucksache_text_list.md),
[`dip_bundestag_person()`](https://buecker.ms/bunddev/reference/dip_bundestag_person.md),
[`dip_bundestag_person_list()`](https://buecker.ms/bunddev/reference/dip_bundestag_person_list.md),
[`dip_bundestag_plenarprotokoll()`](https://buecker.ms/bunddev/reference/dip_bundestag_plenarprotokoll.md),
[`dip_bundestag_plenarprotokoll_list()`](https://buecker.ms/bunddev/reference/dip_bundestag_plenarprotokoll_list.md),
[`dip_bundestag_plenarprotokoll_text()`](https://buecker.ms/bunddev/reference/dip_bundestag_plenarprotokoll_text.md),
[`dip_bundestag_plenarprotokoll_text_list()`](https://buecker.ms/bunddev/reference/dip_bundestag_plenarprotokoll_text_list.md),
[`dip_bundestag_vorgang_list()`](https://buecker.ms/bunddev/reference/dip_bundestag_vorgang_list.md),
[`dip_bundestag_vorgangsposition()`](https://buecker.ms/bunddev/reference/dip_bundestag_vorgangsposition.md),
[`dip_bundestag_vorgangsposition_list()`](https://buecker.ms/bunddev/reference/dip_bundestag_vorgangsposition_list.md)

## Examples

``` r
if (FALSE) { # \dontrun{
dip_bundestag_vorgang(84343)
} # }
```
