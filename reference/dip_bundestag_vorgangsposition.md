# Get a DIP Vorgangsposition

Get a DIP Vorgangsposition

## Usage

``` r
dip_bundestag_vorgangsposition(
  vorgangsposition_id,
  params = list(),
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- vorgangsposition_id:

  Vorgangsposition id.

- params:

  Query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with Vorgangsposition metadata.

## Examples

``` r
if (FALSE) { # \dontrun{
dip_bundestag_vorgangsposition(173376)
} # }
```
