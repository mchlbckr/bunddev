# List OpenAPI parameters for an API

List OpenAPI parameters for an API

## Usage

``` r
bunddev_parameters(id, name = NULL, path = NULL, method = NULL)
```

## Arguments

- id:

  Registry id.

- name:

  Optional parameter name to filter.

- path:

  Optional endpoint path to filter.

- method:

  Optional HTTP method to filter.

## Value

A tibble with parameter metadata.

## Details

Returns one row per parameter defined in the OpenAPI spec. Enumerations
are stored in a list-column (`enum`). Use the filter arguments to narrow
down results to a specific endpoint or parameter name.

## See also

[`bunddev_parameters_for()`](https://mchlbckr.github.io/bunddev/reference/bunddev_parameters_for.md)
for adapter-specific parameters and
[`bunddev_parameter_values()`](https://mchlbckr.github.io/bunddev/reference/bunddev_parameter_values.md)
for enum values.

## Examples

``` r
if (FALSE) { # \dontrun{
bunddev_parameters("smard", name = "resolution")
} # }
```
