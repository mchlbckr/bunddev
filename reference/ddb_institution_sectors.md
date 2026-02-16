# List DDB institution sectors

List DDB institution sectors

## Usage

``` r
ddb_institution_sectors(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with sector entries when the API returns a homogeneous list;
otherwise a one-row tibble with list-column `response`.

## Details

Returns institution sector metadata. Requires the DDB API key.

## See also

Other DDB:
[`ddb_institutions()`](https://buecker.ms/bunddev/reference/ddb_institutions.md),
[`ddb_search()`](https://buecker.ms/bunddev/reference/ddb_search.md)

## Examples

``` r
if (FALSE) { # \dontrun{
ddb_institution_sectors()
} # }
```
