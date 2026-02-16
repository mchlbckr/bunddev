# List approved plant protection products

List approved plant protection products

## Usage

``` r
psm_mittel(kennr = NULL, params = list(), safe = TRUE, refresh = FALSE)
```

## Arguments

- kennr:

  Optional product identification number (9 characters).

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

A tibble with one row per returned API item. Column names follow the
upstream BVL field names; nested objects remain list-columns.

## Details

The Pflanzenschutzmittelzulassung API provides access to Germany's plant
protection product database from the Bundesamt fuer Verbraucherschutz
und Lebensmittelsicherheit (BVL). This function returns approved
pesticides. API documentation:
<https://github.com/bundesAPI/pflanzenschutzmittelzulassung-api>.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.
[`psm_wirkstoffe()`](https://buecker.ms/bunddev/reference/psm_wirkstoffe.md)
to list active ingredients,
[`psm_stand()`](https://buecker.ms/bunddev/reference/psm_stand.md) for
data version.

Other Pflanzenschutzmittelzulassung:
[`psm_anwendungen()`](https://buecker.ms/bunddev/reference/psm_anwendungen.md),
[`psm_kultur_gruppen()`](https://buecker.ms/bunddev/reference/psm_kultur_gruppen.md),
[`psm_schadorg_gruppen()`](https://buecker.ms/bunddev/reference/psm_schadorg_gruppen.md),
[`psm_stand()`](https://buecker.ms/bunddev/reference/psm_stand.md),
[`psm_wirkstoffe()`](https://buecker.ms/bunddev/reference/psm_wirkstoffe.md)

## Examples

``` r
if (FALSE) { # \dontrun{
psm_mittel()
psm_mittel(kennr = "024780-00")
} # }
```
