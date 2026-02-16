# Get Bundesrat voting distribution

Get Bundesrat voting distribution

## Usage

``` r
bundesrat_stimmverteilung(
  view = "render[iOSDetailsWithoutInnerDate]",
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

A tibble with one row per XML `<item>` in the voting distribution feed.
Top-level scalar API fields are returned as tibble columns; nested
objects or arrays are kept in list-columns unless the function provides
`flatten` / `flatten_mode` controls.

## Details

Returns the Bundesrat voting distribution. API documentation:
<https://bundesrat.api.bund.dev>.

## See also

Other Bundesrat:
[`bundesrat_aktuelles()`](https://buecker.ms/bunddev/reference/bundesrat_aktuelles.md),
[`bundesrat_mitglieder()`](https://buecker.ms/bunddev/reference/bundesrat_mitglieder.md),
[`bundesrat_plenum_aktuelle_sitzung()`](https://buecker.ms/bunddev/reference/bundesrat_plenum_aktuelle_sitzung.md),
[`bundesrat_plenum_chronologisch()`](https://buecker.ms/bunddev/reference/bundesrat_plenum_chronologisch.md),
[`bundesrat_plenum_kompakt()`](https://buecker.ms/bunddev/reference/bundesrat_plenum_kompakt.md),
[`bundesrat_plenum_naechste_sitzungen()`](https://buecker.ms/bunddev/reference/bundesrat_plenum_naechste_sitzungen.md),
[`bundesrat_praesidium()`](https://buecker.ms/bunddev/reference/bundesrat_praesidium.md),
[`bundesrat_startlist()`](https://buecker.ms/bunddev/reference/bundesrat_startlist.md),
[`bundesrat_termine()`](https://buecker.ms/bunddev/reference/bundesrat_termine.md)

## Examples

``` r
if (FALSE) { # \dontrun{
bundesrat_stimmverteilung()
} # }
```
