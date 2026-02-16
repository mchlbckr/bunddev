# List collection dates for a house number

List collection dates for a house number

## Usage

``` r
abfallnavi_termine_hausnummern(
  hausnummern_id,
  fraktion,
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- hausnummern_id:

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

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with one
row per collection date and columns:

- id:

  Integer. Collection event identifier.

- bezirk:

  List. District information for this collection.

- datum:

  Character. Collection date (YYYY-MM-DD).

- date_time:

  POSIXct. Parsed collection date (Europe/Berlin).

## See also

Other Abfallnavi:
[`abfallnavi_fraktionen()`](https://buecker.ms/bunddev/reference/abfallnavi_fraktionen.md),
[`abfallnavi_fraktionen_hausnummern()`](https://buecker.ms/bunddev/reference/abfallnavi_fraktionen_hausnummern.md),
[`abfallnavi_fraktionen_strassen()`](https://buecker.ms/bunddev/reference/abfallnavi_fraktionen_strassen.md),
[`abfallnavi_hausnummern()`](https://buecker.ms/bunddev/reference/abfallnavi_hausnummern.md),
[`abfallnavi_kalender_download()`](https://buecker.ms/bunddev/reference/abfallnavi_kalender_download.md),
[`abfallnavi_ort()`](https://buecker.ms/bunddev/reference/abfallnavi_ort.md),
[`abfallnavi_orte()`](https://buecker.ms/bunddev/reference/abfallnavi_orte.md),
[`abfallnavi_strassen()`](https://buecker.ms/bunddev/reference/abfallnavi_strassen.md),
[`abfallnavi_termine_strassen()`](https://buecker.ms/bunddev/reference/abfallnavi_termine_strassen.md)
