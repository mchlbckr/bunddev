# List FAQs

List FAQs

## Usage

``` r
nina_faqs(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with FAQs.

Includes `last_modification_time` as POSIXct in Europe/Berlin.
