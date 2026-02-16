# List DIP Vorgang entries

List DIP Vorgang entries

## Usage

``` r
dip_bundestag_vorgang_list(
  params = list(),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

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
row per Vorgang and columns:

- id:

  Character. Unique Vorgang identifier.

- typ:

  Character. Entity type, always `"Vorgang"`.

- beratungsstand:

  Character. Consultation status.

- vorgangstyp:

  Character. Vorgang type.

- wahlperiode:

  Integer. Legislative period.

- datum:

  Character. Date of last associated document.

- aktualisiert:

  Character. Last update timestamp.

- titel:

  Character. Title text.

- abstract:

  Character. Summary text.

- gesta:

  Character. GESTA reference number.

- kom:

  Character. EU COM reference number.

- ratsdok:

  Character. EU Council document number.

- archiv:

  Character. Archive reference.

- mitteilung:

  Character. Supplementary note.

- sek:

  Character. EU SEC reference number.

- initiative:

  List. Initiating factions or bodies.

- sachgebiet:

  List. Subject areas.

- deskriptor:

  List. Thesaurus descriptor entries.

- zustimmungsbeduerftigkeit:

  List. Consent requirements.

- verkuendung:

  List. Promulgation details.

- inkrafttreten:

  List. Entry-into-force details.

- vorgang_verlinkung:

  List. Linked Vorgaenge.

Wrapped in a one-row tibble with `num_found` (integer), `cursor`
(character), and `documents` (list-column) when not yet unpacked.

## Details

Returns metadata for DIP Vorgang entries. Requires an API key. Obtain a
key from https://dip.bundestag.de/über-dip/hilfe/api.

Configure authentication via
[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
or set the `DIP_BUNDESTAG_API_KEY` environment variable directly.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.
[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
to configure authentication.

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
[`dip_bundestag_vorgang()`](https://buecker.ms/bunddev/reference/dip_bundestag_vorgang.md),
[`dip_bundestag_vorgangsposition()`](https://buecker.ms/bunddev/reference/dip_bundestag_vorgangsposition.md),
[`dip_bundestag_vorgangsposition_list()`](https://buecker.ms/bunddev/reference/dip_bundestag_vorgangsposition_list.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Recommended: use bunddev_auth_set
Sys.setenv(DIP_BUNDESTAG_API_KEY = "<api-key>")
bunddev_auth_set(
  "dip_bundestag",
  type = "api_key",
  env_var = "DIP_BUNDESTAG_API_KEY",
  scheme = "ApiKey"
)
dip_bundestag_vorgang_list()
} # }
```
