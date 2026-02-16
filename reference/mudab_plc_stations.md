# List MUDAB PLC stations

List MUDAB PLC stations

## Usage

``` r
mudab_plc_stations(
  filter = NULL,
  range = NULL,
  orderby = NULL,
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- filter:

  Optional filter definition.

- range:

  Optional range specification.

- orderby:

  Optional ordering specification.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with PLC stations.

## Details

Returns HELCOM PLC stations. Official docs: https://mudab.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
mudab_plc_stations(range = list(from = 0, count = 5))
} # }
```
