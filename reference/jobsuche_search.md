# Search Jobsuche listings

Search Jobsuche listings

## Usage

``` r
jobsuche_search(
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

A tibble with job listings.

Includes parsed POSIXct columns (suffix `_time`) in Europe/Berlin.

## Details

The Jobsuche API provides access to job listings from the Bundesagentur
fuer Arbeit. Authentication is required via an API key passed as
`X-API-Key`. See https://jobsuche.api.bund.dev for the official API
documentation.

Use
[`bunddev_auth_set()`](https://mchlbckr.github.io/bunddev/reference/bunddev_auth_set.md)
to configure the key and
[`bunddev_parameters()`](https://mchlbckr.github.io/bunddev/reference/bunddev_parameters.md)
to discover supported query parameters.

## See also

[`jobsuche_search_app()`](https://mchlbckr.github.io/bunddev/reference/jobsuche_search_app.md)
for the app endpoint,
[`jobsuche_logo()`](https://mchlbckr.github.io/bunddev/reference/jobsuche_logo.md)
to fetch employer logos, and
[`bunddev_auth_set()`](https://mchlbckr.github.io/bunddev/reference/bunddev_auth_set.md)
for authentication.

## Examples

``` r
if (FALSE) { # \dontrun{
Sys.setenv(JOBBOERSE_API_KEY = "jobboerse-jobsuche")
bunddev_auth_set("jobsuche", type = "api_key", env_var = "JOBBOERSE_API_KEY")
jobsuche_search(params = list(was = "data", size = 5), flatten = TRUE)
} # }
```
