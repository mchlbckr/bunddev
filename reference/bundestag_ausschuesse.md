# List Bundestag committees

List Bundestag committees

## Usage

``` r
bundestag_ausschuesse(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with committee entries.

## Details

Returns the committee index from Bundestag XML feeds. Official docs:
https://bundesapi.github.io/bundestag-api/.

## Examples

``` r
if (FALSE) { # \dontrun{
bundestag_ausschuesse()
} # }
```
