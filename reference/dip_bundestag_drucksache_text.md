# Get a DIP Drucksache text

Get a DIP Drucksache text

## Usage

``` r
dip_bundestag_drucksache_text(
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

A tibble with Drucksache text metadata.

## Examples

``` r
if (FALSE) { # \dontrun{
dip_bundestag_drucksache_text(68852)
} # }
```
