# Build a cache path for an API spec

Build a cache path for an API spec

## Usage

``` r
bunddev_spec_path(id)
```

## Arguments

- id:

  Registry id.

## Value

File path where the API specification is cached (character scalar).

## Details

Determines the cache file name based on the spec URL extension
(.yaml/.json).

## See also

[`bunddev_spec()`](https://buecker.ms/bunddev/reference/bunddev_spec.md)
to download and parse specs.

Other OpenAPI:
[`bunddev_cache_dir()`](https://buecker.ms/bunddev/reference/bunddev_cache_dir.md),
[`bunddev_call()`](https://buecker.ms/bunddev/reference/bunddev_call.md),
[`bunddev_call_tidy()`](https://buecker.ms/bunddev/reference/bunddev_call_tidy.md),
[`bunddev_endpoints()`](https://buecker.ms/bunddev/reference/bunddev_endpoints.md),
[`bunddev_ms_to_posix()`](https://buecker.ms/bunddev/reference/bunddev_ms_to_posix.md),
[`bunddev_parameter_values()`](https://buecker.ms/bunddev/reference/bunddev_parameter_values.md),
[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md),
[`bunddev_parameters_for()`](https://buecker.ms/bunddev/reference/bunddev_parameters_for.md),
[`bunddev_spec()`](https://buecker.ms/bunddev/reference/bunddev_spec.md),
[`bunddev_timestamp_to_ms()`](https://buecker.ms/bunddev/reference/bunddev_timestamp_to_ms.md)

## Examples

``` r
if (FALSE) { # \dontrun{
bunddev_spec_path("smard")
} # }
```
