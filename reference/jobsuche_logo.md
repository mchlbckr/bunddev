# Fetch Jobsuche employer logo

Fetch Jobsuche employer logo

## Usage

``` r
jobsuche_logo(hash_id, safe = TRUE, refresh = FALSE)
```

## Arguments

- hash_id:

  Logo hash id.

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A one-row tibble with:

- hash_id:

  Requested logo hash id (character).

- logo:

  Raw logo bytes (list-column with raw vector).

## Details

Returns the raw logo bytes for a given employer hash id. Use this
together with listings returned by
[`jobsuche_search()`](https://buecker.ms/bunddev/reference/jobsuche_search.md)
or
[`jobsuche_search_app()`](https://buecker.ms/bunddev/reference/jobsuche_search_app.md).

See https://jobsuche.api.bund.dev for API documentation.

## See also

[`jobsuche_search()`](https://buecker.ms/bunddev/reference/jobsuche_search.md)
for listings and
[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
for auth setup.

Other Jobsuche:
[`jobsuche_search()`](https://buecker.ms/bunddev/reference/jobsuche_search.md),
[`jobsuche_search_app()`](https://buecker.ms/bunddev/reference/jobsuche_search_app.md)

## Examples

``` r
if (FALSE) { # \dontrun{
Sys.setenv(JOBBOERSE_API_KEY = "jobboerse-jobsuche")
bunddev_auth_set("jobsuche", type = "api_key", env_var = "JOBBOERSE_API_KEY")
logo <- jobsuche_logo("abc123")
} # }
```
