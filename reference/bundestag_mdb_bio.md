# Get a Bundestag biography

Get a Bundestag biography

## Usage

``` r
bundestag_mdb_bio(mdb_id, safe = TRUE, refresh = FALSE)
```

## Arguments

- mdb_id:

  Member id.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with biography fields.

## Details

Returns details for a single member of parliament. Official docs:
https://bundesapi.github.io/bundestag-api/.

## Examples

``` r
if (FALSE) { # \dontrun{
bundestag_mdb_bio(1769)
} # }
```
