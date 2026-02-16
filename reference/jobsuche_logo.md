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

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with raw logo bytes.

## Details

Returns the raw logo bytes for a given employer hash id. Use this
together with listings returned by
[`jobsuche_search()`](https://mchlbckr.github.io/bunddev/reference/jobsuche_search.md)
or
[`jobsuche_search_app()`](https://mchlbckr.github.io/bunddev/reference/jobsuche_search_app.md).

See https://jobsuche.api.bund.dev for API documentation.

## See also

[`jobsuche_search()`](https://mchlbckr.github.io/bunddev/reference/jobsuche_search.md)
for listings and
[`bunddev_auth_set()`](https://mchlbckr.github.io/bunddev/reference/bunddev_auth_set.md)
for auth setup.

## Examples

``` r
if (FALSE) { # \dontrun{
Sys.setenv(JOBBOERSE_API_KEY = "jobboerse-jobsuche")
bunddev_auth_set("jobsuche", type = "api_key", env_var = "JOBBOERSE_API_KEY")
logo <- jobsuche_logo("abc123")
} # }
```
