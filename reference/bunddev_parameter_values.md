# Extract parameter enum values

Extract parameter enum values

## Usage

``` r
bunddev_parameter_values(endpoint, name)
```

## Arguments

- endpoint:

  Adapter function or its name.

- name:

  Parameter name.

## Value

A character vector of enum values.

## Details

Returns unique enum values for a parameter defined on the adapter
endpoint.

## See also

[`bunddev_parameters_for()`](https://mchlbckr.github.io/bunddev/reference/bunddev_parameters_for.md)
to inspect all parameters for an adapter.

## Examples

``` r
if (FALSE) { # \dontrun{
bunddev_parameter_values(smard_timeseries, "resolution")
} # }
```
