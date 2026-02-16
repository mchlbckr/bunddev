# List crop groups

List crop groups

## Usage

``` r
psm_kultur_gruppen(params = list(), safe = TRUE, refresh = FALSE)
```

## Arguments

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

A tibble with crop group catalog entries.

- Item fields:

  One column per top-level field of each `items` element (`m_row$$`
  removed).

- Nested fields:

  Stored as list-columns.

- response:

  Fallback payload for non-item responses (list-column).

## Details

Returns hierarchical crop group classifications.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.

Other Pflanzenschutzmittelzulassung:
[`psm_anwendungen()`](https://buecker.ms/bunddev/reference/psm_anwendungen.md),
[`psm_mittel()`](https://buecker.ms/bunddev/reference/psm_mittel.md),
[`psm_schadorg_gruppen()`](https://buecker.ms/bunddev/reference/psm_schadorg_gruppen.md),
[`psm_stand()`](https://buecker.ms/bunddev/reference/psm_stand.md),
[`psm_wirkstoffe()`](https://buecker.ms/bunddev/reference/psm_wirkstoffe.md)

## Examples

``` r
if (FALSE) { # \dontrun{
psm_kultur_gruppen()
} # }
```
