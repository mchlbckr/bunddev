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

  List of parameters.

- ...:

  Additional arguments passed to the tidier.

## Value

A tibble with tidied results.

## Details

This helper calls
[`bunddev_call()`](https://mchlbckr.github.io/bunddev/reference/bunddev_call.md)
and then applies the adapter-specific tidier for the API. If no tidier
is registered, a tibble containing the raw response is returned.

## See also

[`bunddev_call()`](https://mchlbckr.github.io/bunddev/reference/bunddev_call.md)
for raw responses, and
[`bunddev_parameters()`](https://mchlbckr.github.io/bunddev/reference/bunddev_parameters.md)
to discover available parameters.

## Examples

``` r
if (FALSE) { # \dontrun{
# Tidy Autobahn roadworks
bunddev_call_tidy("autobahn", "list-roadworks", params = list(roadId = "A1"))
} # }
```
