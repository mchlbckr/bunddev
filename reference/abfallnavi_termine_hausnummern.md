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

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with collection dates.

Includes `date_time` as POSIXct in Europe/Berlin.
