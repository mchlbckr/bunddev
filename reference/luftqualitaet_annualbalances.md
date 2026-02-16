# List annual balances

List annual balances

## Usage

``` r
luftqualitaet_annualbalances(params = list(), safe = TRUE, refresh = FALSE)
```

## Arguments

- params:

  Query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with annual balance data.

## Details

Returns annual balance data for a component and year. Official docs:
https://luftqualitaet.api.bund.dev.
