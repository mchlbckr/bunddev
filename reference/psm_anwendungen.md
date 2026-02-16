# List approved applications

List approved applications

## Usage

``` r
psm_anwendungen(
  kennr = NULL,
  awg_id = NULL,
  params = list(),
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- kennr:

  Optional product identification number.

- awg_id:

  Optional application identifier (16 characters).

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

A tibble with one row per approved application item. Guaranteed columns
are top-level fields of each `items` element (with `m_row$$` removed).
Non-item payloads are returned in a `response` list-column.

## Details

Returns approved applications (Anwendungsgebiete) which define the
combinations of products, crops, and pests for which use is permitted.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.
[`psm_mittel()`](https://buecker.ms/bunddev/reference/psm_mittel.md) to
list products.

Other Pflanzenschutzmittelzulassung:
[`psm_kultur_gruppen()`](https://buecker.ms/bunddev/reference/psm_kultur_gruppen.md),
[`psm_mittel()`](https://buecker.ms/bunddev/reference/psm_mittel.md),
[`psm_schadorg_gruppen()`](https://buecker.ms/bunddev/reference/psm_schadorg_gruppen.md),
[`psm_stand()`](https://buecker.ms/bunddev/reference/psm_stand.md),
[`psm_wirkstoffe()`](https://buecker.ms/bunddev/reference/psm_wirkstoffe.md)

## Examples

``` r
if (FALSE) { # \dontrun{
psm_anwendungen(kennr = "024780-00")
} # }
```
