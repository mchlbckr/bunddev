# List thresholds

List thresholds

## Usage

``` r
luftqualitaet_thresholds(params = list(), safe = TRUE, refresh = FALSE)
```

## Arguments

- params:

  Query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with threshold metadata.

## Details

Returns threshold metadata for components and scopes. Official docs:
https://luftqualitaet.api.bund.dev.
