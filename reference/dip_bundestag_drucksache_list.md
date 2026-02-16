# List DIP Drucksachen

List DIP Drucksachen

## Usage

``` r
dip_bundestag_drucksache_list(
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
row per Drucksache and columns:

- id:

  Character. Unique Drucksache identifier.

- typ:

  Character. Entity type, always `"Dokument"`.

- dokumentart:

  Character. Document type, always `"Drucksache"`.

- drucksachetyp:

  Character. Drucksache subtype.

- dokumentnummer:

  Character. Document number.

- wahlperiode:

  Integer. Legislative period.

- herausgeber:

  Character. Publisher: `"BT"` or `"BR"`.

- datum:

  Character. Publication date.

- aktualisiert:

  Character. Last update timestamp.

- titel:

  Character. Title text.

- autoren_anzahl:

  Integer. Total author count.

- pdf_hash:

  Character. MD5 checksum of PDF file.

- vorgangsbezug_anzahl:

  Integer. Total related Vorgaenge.

- anlagen:

  Character. Appendix description.

- autoren_anzeige:

  List. Up to 4 display authors.

- fundstelle:

  List. Document reference details.

- urheber:

  List. Authoring bodies.

- vorgangsbezug:

  List. Related Vorgaenge.

- ressort:

  List. Government departments involved.

Wrapped in a one-row tibble with `num_found` (integer), `cursor`
(character), and `documents` (list-column) when not yet unpacked.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.

Other DIP Bundestag:
[`dip_bundestag_aktivitaet()`](https://buecker.ms/bunddev/reference/dip_bundestag_aktivitaet.md),
[`dip_bundestag_aktivitaet_list()`](https://buecker.ms/bunddev/reference/dip_bundestag_aktivitaet_list.md),
[`dip_bundestag_drucksache()`](https://buecker.ms/bunddev/reference/dip_bundestag_drucksache.md),
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
[`dip_bundestag_vorgangsposition()`](https://buecker.ms/bunddev/reference/dip_bundestag_vorgangsposition.md),
[`dip_bundestag_vorgangsposition_list()`](https://buecker.ms/bunddev/reference/dip_bundestag_vorgangsposition_list.md)

## Examples

``` r
if (FALSE) { # \dontrun{
dip_bundestag_drucksache_list()
} # }
```
