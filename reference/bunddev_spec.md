# Retrieve a cached API spec

Retrieve a cached API spec

## Usage

``` r
bunddev_spec(id, refresh = FALSE)
```

## Arguments

- id:

  Registry id.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`). the API (default `FALSE`).

## Value

Parsed OpenAPI specification as a nested list.

## Details

Downloads the OpenAPI spec from the registry if it is missing or when
`refresh = TRUE`. Parsed specs are returned as lists.

## See also

[`bunddev_endpoints()`](https://buecker.ms/bunddev/reference/bunddev_endpoints.md)
to list operations and
[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect parameters.

Other OpenAPI:
[`bunddev_cache_dir()`](https://buecker.ms/bunddev/reference/bunddev_cache_dir.md),
[`bunddev_call()`](https://buecker.ms/bunddev/reference/bunddev_call.md),
[`bunddev_call_tidy()`](https://buecker.ms/bunddev/reference/bunddev_call_tidy.md),
[`bunddev_endpoints()`](https://buecker.ms/bunddev/reference/bunddev_endpoints.md),
[`bunddev_ms_to_posix()`](https://buecker.ms/bunddev/reference/bunddev_ms_to_posix.md),
[`bunddev_parameter_values()`](https://buecker.ms/bunddev/reference/bunddev_parameter_values.md),
[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md),
[`bunddev_parameters_for()`](https://buecker.ms/bunddev/reference/bunddev_parameters_for.md),
[`bunddev_spec_path()`](https://buecker.ms/bunddev/reference/bunddev_spec_path.md),
[`bunddev_timestamp_to_ms()`](https://buecker.ms/bunddev/reference/bunddev_timestamp_to_ms.md)

## Examples

``` r
if (FALSE) { # \dontrun{
bunddev_spec("smard")
} # }
```
