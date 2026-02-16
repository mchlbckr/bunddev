# List Bundestag members of parliament

List Bundestag members of parliament

## Usage

``` r
bundestag_mdb_index(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with member entries.

## Details

Returns the index of members of parliament. Official docs:
https://bundesapi.github.io/bundestag-api/.

## Examples

``` r
if (FALSE) { # \dontrun{
bundestag_mdb_index()
} # }
```
