# List house numbers for a street

List house numbers for a street

## Usage

``` r
abfallnavi_hausnummern(strassen_id, safe = TRUE, refresh = FALSE)
```

## Arguments

- strassen_id:

  Street id.

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per available house number entry.

Top-level scalar API fields are returned as tibble columns; nested
objects or arrays are kept in list-columns unless the function provides
`flatten` / `flatten_mode` controls.

## See also

Other Abfallnavi:
[`abfallnavi_fraktionen()`](https://buecker.ms/bunddev/reference/abfallnavi_fraktionen.md),
[`abfallnavi_fraktionen_hausnummern()`](https://buecker.ms/bunddev/reference/abfallnavi_fraktionen_hausnummern.md),
[`abfallnavi_fraktionen_strassen()`](https://buecker.ms/bunddev/reference/abfallnavi_fraktionen_strassen.md),
[`abfallnavi_kalender_download()`](https://buecker.ms/bunddev/reference/abfallnavi_kalender_download.md),
[`abfallnavi_ort()`](https://buecker.ms/bunddev/reference/abfallnavi_ort.md),
[`abfallnavi_orte()`](https://buecker.ms/bunddev/reference/abfallnavi_orte.md),
[`abfallnavi_strassen()`](https://buecker.ms/bunddev/reference/abfallnavi_strassen.md),
[`abfallnavi_termine_hausnummern()`](https://buecker.ms/bunddev/reference/abfallnavi_termine_hausnummern.md),
[`abfallnavi_termine_strassen()`](https://buecker.ms/bunddev/reference/abfallnavi_termine_strassen.md)
