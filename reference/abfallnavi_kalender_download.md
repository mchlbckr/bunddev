# Download calendar file

Download calendar file

## Usage

``` r
abfallnavi_kalender_download(
  region,
  format,
  jahr,
  ort,
  strasse,
  hnr,
  fraktion,
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- region:

  Region code.

- format:

  File format.

- jahr:

  Year.

- ort:

  Place name.

- strasse:

  Street id.

- hnr:

  House number id.

- fraktion:

  Fraction ids.

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A one-row tibble with raw downloaded file bytes in a list-column.
Top-level scalar API fields are returned as tibble columns; nested
objects or arrays are kept in list-columns unless the function provides
`flatten` / `flatten_mode` controls.

## Details

Downloads a calendar file for the requested address and fraction.

## See also

Other Abfallnavi:
[`abfallnavi_fraktionen()`](https://buecker.ms/bunddev/reference/abfallnavi_fraktionen.md),
[`abfallnavi_fraktionen_hausnummern()`](https://buecker.ms/bunddev/reference/abfallnavi_fraktionen_hausnummern.md),
[`abfallnavi_fraktionen_strassen()`](https://buecker.ms/bunddev/reference/abfallnavi_fraktionen_strassen.md),
[`abfallnavi_hausnummern()`](https://buecker.ms/bunddev/reference/abfallnavi_hausnummern.md),
[`abfallnavi_ort()`](https://buecker.ms/bunddev/reference/abfallnavi_ort.md),
[`abfallnavi_orte()`](https://buecker.ms/bunddev/reference/abfallnavi_orte.md),
[`abfallnavi_strassen()`](https://buecker.ms/bunddev/reference/abfallnavi_strassen.md),
[`abfallnavi_termine_hausnummern()`](https://buecker.ms/bunddev/reference/abfallnavi_termine_hausnummern.md),
[`abfallnavi_termine_strassen()`](https://buecker.ms/bunddev/reference/abfallnavi_termine_strassen.md)
