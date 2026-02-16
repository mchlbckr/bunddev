# Call an API operation and return tidy data

Call an API operation and return tidy data

## Usage

``` r
bunddev_call_tidy(api, operation_id, params = list(), ...)
```

## Arguments

- api:

  Registry id.

- operation_id:

  OpenAPI operationId.

- params:

  Named list of parameters forwarded to
  [`bunddev_call()`](https://buecker.ms/bunddev/reference/bunddev_call.md).

- ...:

  Additional arguments passed to the tidier.

## Value

A tibble with tidied endpoint data when a tidier is registered for
`api`. Otherwise a one-row tibble with a single list-column `raw`
containing the parsed response object.

## Details

This helper calls
[`bunddev_call()`](https://buecker.ms/bunddev/reference/bunddev_call.md)
and then applies the adapter-specific tidier for the API. If no tidier
is registered, a tibble containing the raw response is returned.

## See also

[`bunddev_call()`](https://buecker.ms/bunddev/reference/bunddev_call.md)
for raw responses, and
[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to discover available parameters.

Other OpenAPI:
[`bunddev_cache_dir()`](https://buecker.ms/bunddev/reference/bunddev_cache_dir.md),
[`bunddev_call()`](https://buecker.ms/bunddev/reference/bunddev_call.md),
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
# Tidy Autobahn roadworks
bunddev_call_tidy("autobahn", "list-roadworks", params = list(roadId = "A1"))
} # }
```
