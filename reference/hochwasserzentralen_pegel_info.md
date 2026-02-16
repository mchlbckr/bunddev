# Get flood gauge information

Get flood gauge information

## Usage

``` r
hochwasserzentralen_pegel_info(pegelnummer, safe = TRUE, refresh = FALSE)
```

## Arguments

- pegelnummer:

  Pegelnummer identifier (e.g., "HE_24820206").

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with pegel metadata.

## Details

Returns metadata for a single flood gauge (pegel) from
hochwasserzentralen.de. Official docs:
https://bundesapi.github.io/hochwasserzentralen-api/.

## Examples

``` r
if (FALSE) { # \dontrun{
hochwasserzentralen_pegel_info("HE_24820206")
} # }
```
