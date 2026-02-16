# Get the current Bundestag speaker

Get the current Bundestag speaker

## Usage

``` r
bundestag_speaker(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with speaker fields.

## Details

Returns the current speaker from the plenum feed. Official docs:
https://bundesapi.github.io/bundestag-api/.

## Examples

``` r
if (FALSE) { # \dontrun{
bundestag_speaker()
} # }
```
