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

A tibble with one row per parameter definition:

- method:

  HTTP method in lower-case (character).

- path:

  OpenAPI path template where the parameter applies (character).

- name:

  Parameter name (character).

- location:

  Parameter location such as `"query"` or `"path"` (character).

- required:

  Whether the parameter is required (`TRUE`/`FALSE`).

- description:

  Parameter description from the spec (character or `NA`).

- schema_type:

  OpenAPI schema type, e.g. `"string"` (character or `NA`).

- enum:

  List-column of allowed values (list of character vectors).

## Details

Returns one row per parameter defined in the OpenAPI spec. Enumerations
are stored in a list-column (`enum`). Use the filter arguments to narrow
down results to a specific endpoint or parameter name.

## See also

[`bunddev_parameters_for()`](https://buecker.ms/bunddev/reference/bunddev_parameters_for.md)
for adapter-specific parameters and
[`bunddev_parameter_values()`](https://buecker.ms/bunddev/reference/bunddev_parameter_values.md)
for enum values.

Other OpenAPI:
[`bunddev_cache_dir()`](https://buecker.ms/bunddev/reference/bunddev_cache_dir.md),
[`bunddev_call()`](https://buecker.ms/bunddev/reference/bunddev_call.md),
[`bunddev_call_tidy()`](https://buecker.ms/bunddev/reference/bunddev_call_tidy.md),
[`bunddev_endpoints()`](https://buecker.ms/bunddev/reference/bunddev_endpoints.md),
[`bunddev_ms_to_posix()`](https://buecker.ms/bunddev/reference/bunddev_ms_to_posix.md),
[`bunddev_parameter_values()`](https://buecker.ms/bunddev/reference/bunddev_parameter_values.md),
[`bunddev_parameters_for()`](https://buecker.ms/bunddev/reference/bunddev_parameters_for.md),
[`bunddev_spec()`](https://buecker.ms/bunddev/reference/bunddev_spec.md),
[`bunddev_spec_path()`](https://buecker.ms/bunddev/reference/bunddev_spec_path.md),
[`bunddev_timestamp_to_ms()`](https://buecker.ms/bunddev/reference/bunddev_timestamp_to_ms.md)

## Examples

``` r
if (FALSE) { # \dontrun{
bunddev_parameters("smard", name = "resolution")
} # }
```
