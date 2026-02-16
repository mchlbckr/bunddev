# List collection dates for a street

List collection dates for a street

## Usage

``` r
abfallnavi_termine_strassen(
  strassen_id,
  fraktion,
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- strassen_id:

  Street id.

- fraktion:

  Fraction ids.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with collection dates.

Includes `date_time` as POSIXct in Europe/Berlin.
