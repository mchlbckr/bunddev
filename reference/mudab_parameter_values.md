# List MUDAB parameter values

List MUDAB parameter values

## Usage

``` r
mudab_parameter_values(
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

A tibble with parameter values.

Includes `datetime_time` as POSIXct in Europe/Berlin when date/time
fields are present.

## Details

Returns measurement values for parameters from the MUDAB database.
Official docs: https://mudab.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
mudab_parameter_values(range = list(from = 0, count = 5))
} # }
```
