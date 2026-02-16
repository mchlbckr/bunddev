# List MUDAB parameters (Biota)

List MUDAB parameters (Biota)

## Usage

``` r
mudab_parameters_biota(
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

A tibble with parameters.

## Details

Returns parameter entries for the Biota compartment. Official docs:
https://mudab.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
mudab_parameters_biota(range = list(from = 0, count = 5))
} # }
```
