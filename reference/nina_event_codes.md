# List NINA event codes

List NINA event codes

## Usage

``` r
nina_event_codes(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with event codes.

Includes `last_modification_time` as POSIXct in Europe/Berlin.
