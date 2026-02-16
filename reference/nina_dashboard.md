# Get NINA dashboard data

Get NINA dashboard data

## Usage

``` r
nina_dashboard(ars, safe = TRUE, refresh = FALSE)
```

## Arguments

- ars:

  ARS code.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with dashboard payload.

## Details

Returns dashboard data for the given ARS code. Official docs:
https://nina.api.bund.dev.
