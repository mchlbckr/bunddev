# List Bundesrat current plenum session entries

List Bundesrat current plenum session entries

## Usage

``` r
bundesrat_plenum_aktuelle_sitzung(
  view = "renderXml",
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- view:

  Rendering mode for the XML output.

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per XML `<item>` for the current session feed.

- XML child-tag columns:

  One column per scalar child element in each `<item>` node.

- Repeated child tags:

  Stored as list-columns.

- `date_time`, `dateOfIssue_time`, `imageDate_time`, `layoutDate_time`,
  `startdate_time`, `stopdate_time`:

  Parsed `POSIXct` values in Europe/Berlin when the corresponding source
  fields are present.

## Details

Returns entries for the current plenum session. API documentation:
<https://bundesrat.api.bund.dev>.

## See also

Other Bundesrat:
[`bundesrat_aktuelles()`](https://buecker.ms/bunddev/reference/bundesrat_aktuelles.md),
[`bundesrat_mitglieder()`](https://buecker.ms/bunddev/reference/bundesrat_mitglieder.md),
[`bundesrat_plenum_chronologisch()`](https://buecker.ms/bunddev/reference/bundesrat_plenum_chronologisch.md),
[`bundesrat_plenum_kompakt()`](https://buecker.ms/bunddev/reference/bundesrat_plenum_kompakt.md),
[`bundesrat_plenum_naechste_sitzungen()`](https://buecker.ms/bunddev/reference/bundesrat_plenum_naechste_sitzungen.md),
[`bundesrat_praesidium()`](https://buecker.ms/bunddev/reference/bundesrat_praesidium.md),
[`bundesrat_startlist()`](https://buecker.ms/bunddev/reference/bundesrat_startlist.md),
[`bundesrat_stimmverteilung()`](https://buecker.ms/bunddev/reference/bundesrat_stimmverteilung.md),
[`bundesrat_termine()`](https://buecker.ms/bunddev/reference/bundesrat_termine.md)

## Examples

``` r
if (FALSE) { # \dontrun{
bundesrat_plenum_aktuelle_sitzung()
} # }
```
