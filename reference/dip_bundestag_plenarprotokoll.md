# Get a DIP Plenarprotokoll

Get a DIP Plenarprotokoll

## Usage

``` r
dip_bundestag_plenarprotokoll(
  plenarprotokoll_id,
  params = list(),
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- plenarprotokoll_id:

  Plenarprotokoll id.

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

A one-row tibble for the selected Plenarprotokoll:

- id:

  Plenarprotokoll identifier (character).

- dokumentart:

  Document type, always `"Plenarprotokoll"` (character).

- typ:

  Entity type, always `"Dokument"` (character).

- dokumentnummer:

  Document number, e.g. `"19/1"` (character).

- wahlperiode:

  Legislative period (integer).

- herausgeber:

  Publisher assignment (character).

- datum:

  Session date (character, ISO date).

- aktualisiert:

  Last update timestamp (character, ISO datetime).

- titel:

  Title (character).

- fundstelle:

  Document reference details (list-column).

- pdf_hash:

  MD5 checksum of the PDF file (character or `NA`).

- vorgangsbezug:

  Up to 4 related Vorgänge (list-column).

- vorgangsbezug_anzahl:

  Total number of related Vorgänge (integer).

- sitzungsbemerkung:

  Session remark, e.g. `"Sondersitzung"` (character or `NA`).

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
[`dip_bundestag_plenarprotokoll_list()`](https://buecker.ms/bunddev/reference/dip_bundestag_plenarprotokoll_list.md),
[`dip_bundestag_plenarprotokoll_text()`](https://buecker.ms/bunddev/reference/dip_bundestag_plenarprotokoll_text.md),
[`dip_bundestag_plenarprotokoll_text_list()`](https://buecker.ms/bunddev/reference/dip_bundestag_plenarprotokoll_text_list.md),
[`dip_bundestag_vorgang()`](https://buecker.ms/bunddev/reference/dip_bundestag_vorgang.md),
[`dip_bundestag_vorgang_list()`](https://buecker.ms/bunddev/reference/dip_bundestag_vorgang_list.md),
[`dip_bundestag_vorgangsposition()`](https://buecker.ms/bunddev/reference/dip_bundestag_vorgangsposition.md),
[`dip_bundestag_vorgangsposition_list()`](https://buecker.ms/bunddev/reference/dip_bundestag_vorgangsposition_list.md)

## Examples

``` r
if (FALSE) { # \dontrun{
dip_bundestag_plenarprotokoll(908)
} # }
```
