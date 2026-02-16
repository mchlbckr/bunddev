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

  Named list of query parameters. Common keys:

  query

  :   Search string (set automatically from `query`).

  offset

  :   Start index for pagination (integer).

  length

  :   Maximum number of returned items (integer).

  facet

  :   Facet selection(s) supported by the DDB search API (character).

  sort

  :   Sort key/order (character).

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

- flatten:

  Logical; if `TRUE`, simplify nested list columns according to
  `flatten_mode`. Default `FALSE` keeps list columns as-is.

- flatten_mode:

  How to handle list columns when `flatten = TRUE`:

  `"drop"`

  :   Remove list columns entirely. Use when nested data is not needed.

  `"json"`

  :   Convert each list element to a JSON string. Preserves all data in
      a text-queryable format. This is the **default**.

  `"unnest"`

  :   Expand list columns into multiple rows via
      [`tidyr::unnest_longer()`](https://tidyr.tidyverse.org/reference/unnest_longer.html).
      **Warning:** this can significantly increase the number of rows.

## Value

A one-row tibble with one list-column:

- response:

  Full parsed DDB search payload (list-column).

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

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.
[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
to configure authentication.

Other DDB:
[`ddb_institution_sectors()`](https://buecker.ms/bunddev/reference/ddb_institution_sectors.md),
[`ddb_institutions()`](https://buecker.ms/bunddev/reference/ddb_institutions.md)

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
