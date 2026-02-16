# Get a DIP Vorgang

Get a DIP Vorgang

## Usage

``` r
dip_bundestag_vorgang(
  vorgang_id,
  params = list(),
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- vorgang_id:

  Vorgang id.

- params:

  Query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with Vorgang metadata.

## Details

Returns metadata for a single Vorgang.

## Examples

``` r
if (FALSE) { # \dontrun{
dip_bundestag_vorgang(84343)
} # }
```
