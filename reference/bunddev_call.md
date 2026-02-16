# Call an API operation

Call an API operation

## Usage

``` r
bunddev_call(
  api,
  operation_id = NULL,
  params = list(),
  path = NULL,
  method = NULL,
  parse = c("json", "text", "raw", "xml"),
  base_url = NULL,
  body = NULL,
  body_type = c("json", "form"),
  headers = NULL,
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- api:

  Registry id.

- operation_id:

  OpenAPI operationId (use this OR path+method).

- params:

  List of query parameters.

- path:

  API path (use with method instead of operation_id).

- method:

  HTTP method (use with path instead of operation_id).

- parse:

  Response parsing mode.

- base_url:

  Optional base URL override.

- body:

  Optional request body (for POST/PUT requests).

- body_type:

  Body encoding type ("json" or "form").

- headers:

  Optional named list of custom HTTP headers.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached GET responses.

## Value

Parsed response.

## Details

This is the low-level OpenAPI caller. It supports two modes:

- Use `operation_id` to lookup endpoints by their OpenAPI operationId

- Use `path` + `method` for APIs without operationIds

The function fills path parameters from `params`, applies auth (if
configured), and optionally caches GET responses when `safe = TRUE`.

Use
[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
and
[`bunddev_parameter_values()`](https://buecker.ms/bunddev/reference/bunddev_parameter_values.md)
to discover valid parameters before calling.

## See also

[`bunddev_call_tidy()`](https://buecker.ms/bunddev/reference/bunddev_call_tidy.md)
for adapter-specific tidy outputs, and
[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
to configure API keys.

## Examples

``` r
if (FALSE) { # \dontrun{
# Retrieve Autobahn road ids (raw response)
bunddev_call("autobahn", "list-autobahnen")
} # }
```
