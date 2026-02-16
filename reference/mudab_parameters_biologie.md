# List MUDAB parameters (Biologie)

List MUDAB parameters (Biologie)

## Usage

``` r
mudab_parameters_biologie(
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

Returns parameter entries for the Biologie compartment. Official docs:
https://mudab.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
mudab_parameters_biologie(range = list(from = 0, count = 5))
} # }
```
