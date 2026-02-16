# List MUDAB PLC parameters

List MUDAB PLC parameters

## Usage

``` r
mudab_plc_parameters(
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

A tibble with PLC parameters.

## Details

Returns parameters measured at PLC stations. Official docs:
https://mudab.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
mudab_plc_parameters(range = list(from = 0, count = 5))
} # }
```
