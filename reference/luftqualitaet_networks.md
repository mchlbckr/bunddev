# List networks

List networks

## Usage

``` r
luftqualitaet_networks(params = list(), safe = TRUE, refresh = FALSE)
```

## Arguments

- params:

  Query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with network metadata.

## Details

Returns networks used by the Luftqualitaet API. Official docs:
https://luftqualitaet.api.bund.dev.
