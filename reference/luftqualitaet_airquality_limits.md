# Get air quality date limits

Get air quality date limits

## Usage

``` r
luftqualitaet_airquality_limits(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with date limits.

## Details

Returns date limits for air quality measurements. Official docs:
https://luftqualitaet.api.bund.dev.
