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

A tibble with the same columns as
[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md),
filtered to the OpenAPI path/method associated with `endpoint`.

## Details

Resolves the adapter to an OpenAPI path/method mapping and filters
parameters accordingly.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
for the full API parameter table.

Other OpenAPI:
[`bunddev_cache_dir()`](https://buecker.ms/bunddev/reference/bunddev_cache_dir.md),
[`bunddev_call()`](https://buecker.ms/bunddev/reference/bunddev_call.md),
[`bunddev_call_tidy()`](https://buecker.ms/bunddev/reference/bunddev_call_tidy.md),
[`bunddev_endpoints()`](https://buecker.ms/bunddev/reference/bunddev_endpoints.md),
[`bunddev_ms_to_posix()`](https://buecker.ms/bunddev/reference/bunddev_ms_to_posix.md),
[`bunddev_parameter_values()`](https://buecker.ms/bunddev/reference/bunddev_parameter_values.md),
[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md),
[`bunddev_spec()`](https://buecker.ms/bunddev/reference/bunddev_spec.md),
[`bunddev_spec_path()`](https://buecker.ms/bunddev/reference/bunddev_spec_path.md),
[`bunddev_timestamp_to_ms()`](https://buecker.ms/bunddev/reference/bunddev_timestamp_to_ms.md)

## Examples

``` r
if (FALSE) { # \dontrun{
bunddev_parameters_for(smard_timeseries)
} # }
```
