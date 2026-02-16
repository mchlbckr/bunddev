# List flood gauge locations

List flood gauge locations

## Usage

``` r
hochwasserzentralen_lagepegel(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with pegel coordinates.

## Details

Returns latitude/longitude coordinates for all pegel identifiers
available in the hochwasserzentralen.de portal. Official docs:
https://bundesapi.github.io/hochwasserzentralen-api/.

## Examples

``` r
if (FALSE) { # \dontrun{
hochwasserzentralen_lagepegel()
} # }
```
