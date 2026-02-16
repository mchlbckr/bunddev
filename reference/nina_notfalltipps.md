# List emergency tips

List emergency tips

## Usage

``` r
nina_notfalltipps(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with emergency tips.

Includes `last_modification_time` as POSIXct in Europe/Berlin.
