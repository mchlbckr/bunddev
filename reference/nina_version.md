# Get data version info

Get data version info

## Usage

``` r
nina_version(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with version data.

Includes `last_modification_time` as POSIXct in Europe/Berlin.
