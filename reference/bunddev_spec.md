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

  Logical; refresh cached spec.

## Value

Parsed OpenAPI spec.

## Details

Downloads the OpenAPI spec from the registry if it is missing or when
`refresh = TRUE`. Parsed specs are returned as lists.

## See also

[`bunddev_endpoints()`](https://buecker.ms/bunddev/reference/bunddev_endpoints.md)
to list operations and
[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect parameters.

## Examples

``` r
if (FALSE) { # \dontrun{
bunddev_spec("smard")
} # }
```
