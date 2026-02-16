# Get a DIP Aktivität

Get a DIP Aktivität

## Usage

``` r
dip_bundestag_aktivitaet(
  aktivitaet_id,
  params = list(),
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- aktivitaet_id:

  Aktivität id.

- params:

  Query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with Aktivität metadata.

## Examples

``` r
if (FALSE) { # \dontrun{
dip_bundestag_aktivitaet(1493545)
} # }
```
