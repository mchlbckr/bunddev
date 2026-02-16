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

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with raw file bytes.

## Details

Downloads a calendar file for the requested address and fraction.
