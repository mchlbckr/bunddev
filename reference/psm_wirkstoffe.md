# List active ingredients

List active ingredients

## Usage

``` r
psm_wirkstoffe(
  wirkstoffId = NULL,
  params = list(),
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- wirkstoffId:

  Optional active ingredient ID.

- params:

  Named list of query parameters. Frequently used keys:

  kennr

  :   Product id (e.g. `"024780-00"`).

  wirkstoffId

  :   Active ingredient id.

  awg_id

  :   Application id.

  kultur

  :   Crop filter code.

  kultur_gruppe

  :   Crop group filter code.

  kode

  :   Code filter for catalog lookups.

  kodeliste

  :   Code list name.

  sprache

  :   Language code.

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per active ingredient item. Guaranteed columns are
top-level fields of each `items` element (with `m_row$$` removed).
Non-item payloads are returned in a `response` list-column.

## Details

Returns active ingredients (Wirkstoffe) from the plant protection
product database.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.
[`psm_mittel()`](https://buecker.ms/bunddev/reference/psm_mittel.md) to
list products.

Other Pflanzenschutzmittelzulassung:
[`psm_anwendungen()`](https://buecker.ms/bunddev/reference/psm_anwendungen.md),
[`psm_kultur_gruppen()`](https://buecker.ms/bunddev/reference/psm_kultur_gruppen.md),
[`psm_mittel()`](https://buecker.ms/bunddev/reference/psm_mittel.md),
[`psm_schadorg_gruppen()`](https://buecker.ms/bunddev/reference/psm_schadorg_gruppen.md),
[`psm_stand()`](https://buecker.ms/bunddev/reference/psm_stand.md)

## Examples

``` r
if (FALSE) { # \dontrun{
psm_wirkstoffe()
} # }
```
