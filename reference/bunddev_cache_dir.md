# Locate the bunddev cache directory

Locate the bunddev cache directory

## Usage

``` r
bunddev_cache_dir()
```

## Value

Path to the `bunddev` cache directory (character scalar).

## Details

The cache directory is used to store downloaded OpenAPI specs and cached
API responses. Use this to inspect or clean cached files.

## See also

[`bunddev_spec()`](https://buecker.ms/bunddev/reference/bunddev_spec.md)
to download specs, and
[`bunddev_spec_path()`](https://buecker.ms/bunddev/reference/bunddev_spec_path.md)
to locate a specific spec file.

Other OpenAPI:
[`bunddev_call()`](https://buecker.ms/bunddev/reference/bunddev_call.md),
[`bunddev_call_tidy()`](https://buecker.ms/bunddev/reference/bunddev_call_tidy.md),
[`bunddev_endpoints()`](https://buecker.ms/bunddev/reference/bunddev_endpoints.md),
[`bunddev_ms_to_posix()`](https://buecker.ms/bunddev/reference/bunddev_ms_to_posix.md),
[`bunddev_parameter_values()`](https://buecker.ms/bunddev/reference/bunddev_parameter_values.md),
[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md),
[`bunddev_parameters_for()`](https://buecker.ms/bunddev/reference/bunddev_parameters_for.md),
[`bunddev_spec()`](https://buecker.ms/bunddev/reference/bunddev_spec.md),
[`bunddev_spec_path()`](https://buecker.ms/bunddev/reference/bunddev_spec_path.md),
[`bunddev_timestamp_to_ms()`](https://buecker.ms/bunddev/reference/bunddev_timestamp_to_ms.md)

## Examples

``` r
if (FALSE) { # \dontrun{
bunddev_cache_dir()
} # }
```
