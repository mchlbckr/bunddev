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

A character vector of unique enum values. Returns `character(0)` if no
enum is declared for the selected parameter.

## Details

Returns unique enum values for a parameter defined on the adapter
endpoint.

## See also

[`bunddev_parameters_for()`](https://buecker.ms/bunddev/reference/bunddev_parameters_for.md)
to inspect all parameters for an adapter.

Other OpenAPI:
[`bunddev_cache_dir()`](https://buecker.ms/bunddev/reference/bunddev_cache_dir.md),
[`bunddev_call()`](https://buecker.ms/bunddev/reference/bunddev_call.md),
[`bunddev_call_tidy()`](https://buecker.ms/bunddev/reference/bunddev_call_tidy.md),
[`bunddev_endpoints()`](https://buecker.ms/bunddev/reference/bunddev_endpoints.md),
[`bunddev_ms_to_posix()`](https://buecker.ms/bunddev/reference/bunddev_ms_to_posix.md),
[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md),
[`bunddev_parameters_for()`](https://buecker.ms/bunddev/reference/bunddev_parameters_for.md),
[`bunddev_spec()`](https://buecker.ms/bunddev/reference/bunddev_spec.md),
[`bunddev_spec_path()`](https://buecker.ms/bunddev/reference/bunddev_spec_path.md),
[`bunddev_timestamp_to_ms()`](https://buecker.ms/bunddev/reference/bunddev_timestamp_to_ms.md)

## Examples

``` r
if (FALSE) { # \dontrun{
bunddev_parameter_values(smard_timeseries, "resolution")
} # }
```
