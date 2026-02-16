# List DIP Vorgang entries

List DIP Vorgang entries

## Usage

``` r
dip_bundestag_vorgang_list(
  params = list(),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- params:

  Query parameters.

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

A tibble with DIP response metadata.

## Details

Returns metadata for DIP Vorgang entries. Requires an API key. Obtain a
key from https://dip.bundestag.de/über-dip/hilfe/api.

Configure authentication via
[`bunddev_auth_set()`](https://mchlbckr.github.io/bunddev/reference/bunddev_auth_set.md)
or set the `DIP_BUNDESTAG_API_KEY` environment variable directly.

## See also

[`bunddev_auth_set()`](https://mchlbckr.github.io/bunddev/reference/bunddev_auth_set.md)
to configure authentication.

## Examples

``` r
if (FALSE) { # \dontrun{
# Recommended: use bunddev_auth_set
Sys.setenv(DIP_BUNDESTAG_API_KEY = "<api-key>")
bunddev_auth_set(
  "dip_bundestag",
  type = "api_key",
  env_var = "DIP_BUNDESTAG_API_KEY",
  scheme = "ApiKey"
)
dip_bundestag_vorgang_list()
} # }
```
