# List measurements metadata

List measurements metadata

## Usage

``` r
luftqualitaet_measures(params = list(), safe = TRUE, refresh = FALSE)
```

## Arguments

- params:

  Query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with measurement metadata.

## Details

Returns measurement metadata for stations, components, and scopes.
Official docs: https://luftqualitaet.api.bund.dev.
