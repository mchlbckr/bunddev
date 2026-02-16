# Get Bundestag committee details

Get Bundestag committee details

## Usage

``` r
bundestag_ausschuss(ausschuss_id, safe = TRUE, refresh = FALSE)
```

## Arguments

- ausschuss_id:

  Committee id (e.g. "a11").

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with committee details.

## Details

Returns details for a single committee. Official docs:
https://bundesapi.github.io/bundestag-api/.

## Examples

``` r
if (FALSE) { # \dontrun{
bundestag_ausschuss("a11")
} # }
```
