# List DDB institution sectors

List DDB institution sectors

## Usage

``` r
ddb_institution_sectors(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with sector entries.

## Details

Returns institution sector metadata. Requires the DDB API key.

## Examples

``` r
if (FALSE) { # \dontrun{
ddb_institution_sectors()
} # }
```
