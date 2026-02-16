# List DIP Vorgangsposition entries

List DIP Vorgangsposition entries

## Usage

``` r
dip_bundestag_vorgangsposition_list(
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
row per Vorgangsposition and columns:

- id:

  Character. Unique Vorgangsposition identifier.

- vorgangsposition:

  Character. Step description.

- gang:

  Logical. Key step in legislative process.

- fortsetzung:

  Logical. Continuation of prior debate.

- nachtrag:

  Logical. Addendum entry.

- vorgangstyp:

  Character. Parent Vorgang type.

- typ:

  Character. Entity type, always `"Vorgangsposition"`.

- titel:

  Character. Title of the parent Vorgang.

- dokumentart:

  Character. Document type.

- vorgang_id:

  Character. Parent Vorgang identifier.

- datum:

  Character. Date of associated document.

- aktualisiert:

  Character. Last update timestamp.

- aktivitaet_anzahl:

  Integer. Total associated activities.

- ratsdok:

  Character. EU Council document number.

- kom:

  Character. EU COM reference number.

- sek:

  Character. EU SEC reference number.

- abstract:

  Character. Summary text.

- zuordnung:

  List. Assignment to BT/BR/BV/EK.

- fundstelle:

  List. Document reference details.

- urheber:

  List. Authoring bodies.

- ueberweisung:

  List. Committee referrals.

- aktivitaet_anzeige:

  List. Up to 4 display activities.

- ressort:

  List. Government departments involved.

- beschlussfassung:

  List. Voting decisions.

- mitberaten:

  List. Co-deliberated Vorgangspositionen.

Wrapped in a one-row tibble with `num_found` (integer), `cursor`
(character), and `documents` (list-column) when not yet unpacked.

## Details

Returns metadata for Vorgangsposition entries.

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
[`dip_bundestag_vorgang()`](https://buecker.ms/bunddev/reference/dip_bundestag_vorgang.md),
[`dip_bundestag_vorgang_list()`](https://buecker.ms/bunddev/reference/dip_bundestag_vorgang_list.md),
[`dip_bundestag_vorgangsposition()`](https://buecker.ms/bunddev/reference/dip_bundestag_vorgangsposition.md)

## Examples

``` r
if (FALSE) { # \dontrun{
dip_bundestag_vorgangsposition_list()
} # }
```
