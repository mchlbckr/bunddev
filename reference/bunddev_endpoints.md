# Retrieve endpoints for a given API

Retrieve endpoints for a given API

List OpenAPI endpoints for an API

## Usage

``` r
bunddev_endpoints(id)

bunddev_endpoints(id)
```

## Arguments

- id:

  Registry id.

## Value

A tibble with columns method, path, operation_id, summary

A tibble with endpoints.

## Details

Parses the cached OpenAPI spec and returns every available path + method
with its operationId and summary, if provided.

## See also

[`bunddev_parameters()`](https://mchlbckr.github.io/bunddev/reference/bunddev_parameters.md)
to inspect parameters and
[`bunddev_spec()`](https://mchlbckr.github.io/bunddev/reference/bunddev_spec.md)
to access the full spec.

## Examples

``` r
if (FALSE) { # \dontrun{
bunddev_endpoints("autobahn")
} # }
```
