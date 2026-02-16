# Get a DIP Drucksache

Get a DIP Drucksache

## Usage

``` r
dip_bundestag_drucksache(
  drucksache_id,
  params = list(),
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- drucksache_id:

  Drucksache id.

- params:

  Query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with Drucksache metadata.

## Examples

``` r
if (FALSE) { # \dontrun{
dip_bundestag_drucksache(68852)
} # }
```
