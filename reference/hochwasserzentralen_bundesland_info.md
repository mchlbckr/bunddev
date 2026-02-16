# Get flood portal metadata for a Bundesland

Get flood portal metadata for a Bundesland

## Usage

``` r
hochwasserzentralen_bundesland_info(
  bundesland_id,
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- bundesland_id:

  Bundesland id (e.g., "HE").

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with Bundesland metadata.

## Details

Returns metadata for a single Bundesland or region in the
hochwasserzentralen.de portal. Official docs:
https://bundesapi.github.io/hochwasserzentralen-api/.

## Examples

``` r
if (FALSE) { # \dontrun{
hochwasserzentralen_bundesland_info("HE")
} # }
```
