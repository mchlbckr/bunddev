# List OpenAPI parameters for a specific adapter

List OpenAPI parameters for a specific adapter

## Usage

``` r
bunddev_parameters_for(endpoint)
```

## Arguments

- endpoint:

  Adapter function or its name.

## Value

A tibble with parameter metadata.

## Details

Resolves the adapter to an OpenAPI path/method mapping and filters
parameters accordingly.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
for the full API parameter table.

## Examples

``` r
if (FALSE) { # \dontrun{
bunddev_parameters_for(smard_timeseries)
} # }
```
