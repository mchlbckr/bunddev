# List flood portal states and connected regions

List flood portal states and connected regions

## Usage

``` r
hochwasserzentralen_bundeslaender(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with Bundesland metadata.

## Details

Returns metadata for all Bundeslaender and connected regions in the
hochwasserzentralen.de portal. Official docs:
https://bundesapi.github.io/hochwasserzentralen-api/.

## Examples

``` r
if (FALSE) { # \dontrun{
hochwasserzentralen_bundeslaender()
} # }
```
