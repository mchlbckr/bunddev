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

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with one
row per approved application and columns:

- ANTRAGNR:

  Character. Application request number.

- ANWENDUNGEN_ANZ_JE_BEFALL:

  Numeric. Applications per infestation.

- ANWENDUNGEN_MAX_JE_KULTUR:

  Numeric. Max applications per crop.

- ANWENDUNGEN_MAX_JE_VEGETATION:

  Numeric. Max applications per vegetation period.

- ANWENDUNGSBEREICH:

  Character. Area of use code.

- ANWENDUNGSTECHNIK:

  Character. Application technique.

- AWGNR:

  Character. Application group number.

- AWG_ID:

  Character. Application identifier (16 chars).

- AW_ABSTAND_BIS:

  Numeric. Application interval upper bound.

- AW_ABSTAND_EINHEIT:

  Character. Interval unit.

- AW_ABSTAND_VON:

  Numeric. Application interval lower bound.

- EINSATZGEBIET:

  Character. Field of use code.

- GENEHMIGUNG:

  Character. Approval flag.

- HUK:

  Character. Home-and-garden flag.

- KENNR:

  Character. Product identification number.

- KULTUR_ERL:

  Character. Crop clarification text.

- SCHADORG_ERL:

  Character. Pest clarification text.

- STADIUM_KULTUR_BEM:

  Character. Crop growth-stage note.

- STADIUM_KULTUR_BIS:

  Character. Crop growth-stage upper bound.

- STADIUM_KULTUR_KODELISTE:

  Numeric. Crop growth-stage code list.

- STADIUM_KULTUR_VON:

  Character. Crop growth-stage lower bound.

- STADIUM_SCHADORG_BEM:

  Character. Pest growth-stage note.

- STADIUM_SCHADORG_BIS:

  Character. Pest growth-stage upper bound.

- STADIUM_SCHADORG_KODELISTE:

  Numeric. Pest growth-stage code list.

- STADIUM_SCHADORG_VON:

  Character. Pest growth-stage lower bound.

- WIRKUNGSBEREICH:

  Character. Efficacy area code.

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
