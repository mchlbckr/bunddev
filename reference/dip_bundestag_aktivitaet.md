# Get a DIP Aktivität

Get a DIP Aktivität

## Usage

``` r
dip_bundestag_aktivitaet(
  aktivitaet_id,
  params = list(),
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- aktivitaet_id:

  Aktivität id.

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

A one-row tibble with detailed fields for the selected Aktivitaet.

- num_found:

  List endpoints: total number of matches (integer).

- cursor:

  List endpoints: cursor for pagination (character).

- documents:

  List endpoints: returned records as list-column.

- Detail fields:

  Detail endpoints: one column per top-level scalar field, with nested
  structures in list-columns.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.

Other DIP Bundestag:
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
[`dip_bundestag_vorgangsposition()`](https://buecker.ms/bunddev/reference/dip_bundestag_vorgangsposition.md),
[`dip_bundestag_vorgangsposition_list()`](https://buecker.ms/bunddev/reference/dip_bundestag_vorgangsposition_list.md)

## Examples

``` r
if (FALSE) { # \dontrun{
dip_bundestag_aktivitaet(1493545)
} # }
```
