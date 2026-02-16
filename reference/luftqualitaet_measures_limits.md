# Get measurement date limits

Get measurement date limits

## Usage

``` r
luftqualitaet_measures_limits(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with date limits.

## Details

Returns date limits for measurement metadata. Official docs:
https://luftqualitaet.api.bund.dev.
