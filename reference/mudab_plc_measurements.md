# List MUDAB PLC measurement values

List MUDAB PLC measurement values

## Usage

``` r
mudab_plc_measurements(
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

A tibble with PLC measurements.

## Details

Returns PLC station measurement values. Official docs:
https://mudab.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
mudab_plc_measurements(range = list(from = 0, count = 5))
} # }
```
