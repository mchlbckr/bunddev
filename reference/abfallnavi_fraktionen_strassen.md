# List waste fractions for a street

List waste fractions for a street

## Usage

``` r
abfallnavi_fraktionen_strassen(strassen_id, safe = TRUE, refresh = FALSE)
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

A tibble with one row per waste fraction entry for the selected street.

- Top-level scalar fields:

  One column per scalar field returned by the endpoint (for example ids,
  names, labels, and codes).

- Nested fields:

  Kept as list-columns.

- date_time:

  Added by `abfallnavi_termine_*()` from `datum` as `POSIXct` in
  Europe/Berlin, when available.

## See also

Other Abfallnavi:
[`abfallnavi_fraktionen()`](https://buecker.ms/bunddev/reference/abfallnavi_fraktionen.md),
[`abfallnavi_fraktionen_hausnummern()`](https://buecker.ms/bunddev/reference/abfallnavi_fraktionen_hausnummern.md),
[`abfallnavi_hausnummern()`](https://buecker.ms/bunddev/reference/abfallnavi_hausnummern.md),
[`abfallnavi_kalender_download()`](https://buecker.ms/bunddev/reference/abfallnavi_kalender_download.md),
[`abfallnavi_ort()`](https://buecker.ms/bunddev/reference/abfallnavi_ort.md),
[`abfallnavi_orte()`](https://buecker.ms/bunddev/reference/abfallnavi_orte.md),
[`abfallnavi_strassen()`](https://buecker.ms/bunddev/reference/abfallnavi_strassen.md),
[`abfallnavi_termine_hausnummern()`](https://buecker.ms/bunddev/reference/abfallnavi_termine_hausnummern.md),
[`abfallnavi_termine_strassen()`](https://buecker.ms/bunddev/reference/abfallnavi_termine_strassen.md)
