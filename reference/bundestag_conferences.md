# Get Bundestag conferences overview

Get Bundestag conferences overview

## Usage

``` r
bundestag_conferences(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with conference fields.

## Details

Returns conference overview data from the plenum feed. Official docs:
https://bundesapi.github.io/bundestag-api/.

## Examples

``` r
if (FALSE) { # \dontrun{
bundestag_conferences()
} # }
```
