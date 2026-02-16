# Search Deutsche Digitale Bibliothek

Search Deutsche Digitale Bibliothek

## Usage

``` r
ddb_search(
  query,
  params = list(),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- query:

  Search query string.

- params:

  Additional query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with search metadata and result payload.

## Details

Returns search results from the Deutsche Digitale Bibliothek API. You
need an API key from
https://www.deutsche-digitale-bibliothek.de/user/apikey. The key is sent
in the `Authorization` header as `OAuth oauth_consumer_key="<key>"`.

Configure authentication via
[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
using a template-style scheme, or set the `DDB_API_KEY` environment
variable directly.

## See also

[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
to configure authentication.

## Examples

``` r
if (FALSE) { # \dontrun{
# Recommended: use bunddev_auth_set with template scheme
Sys.setenv(DDB_API_KEY = "<api-key>")
bunddev_auth_set("ddb", type = "api_key", env_var = "DDB_API_KEY",
                 scheme = "OAuth oauth_consumer_key=\"%s\"")
ddb_search(query = "berlin", params = list(rows = 5))
} # }
```
