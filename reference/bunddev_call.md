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

  Named list of query and path parameters passed to the selected
  operation.

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

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

Parsed response according to `parse`:

- `parse = "json"`:

  Parsed JSON as an R list.

- `parse = "text"`:

  Character scalar with response body text.

- `parse = "raw"`:

  Raw vector with response bytes.

- `parse = "xml"`:

  `xml2` document object.

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

Other OpenAPI:
[`bunddev_cache_dir()`](https://buecker.ms/bunddev/reference/bunddev_cache_dir.md),
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
# Retrieve Autobahn road ids (raw response)
bunddev_call("autobahn", "list-autobahnen")
} # }
```
