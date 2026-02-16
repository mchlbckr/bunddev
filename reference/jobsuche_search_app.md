# Search Jobsuche listings (app endpoint)

Search Jobsuche listings (app endpoint)

## Usage

``` r
jobsuche_search_app(
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

This uses the mobile app endpoint of the Jobsuche API. It shares the
same authentication mechanism and parameters as
[`jobsuche_search()`](https://buecker.ms/bunddev/reference/jobsuche_search.md).

See https://jobsuche.api.bund.dev for API documentation.

## See also

[`jobsuche_search()`](https://buecker.ms/bunddev/reference/jobsuche_search.md)
for the standard endpoint and
[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
for parameter discovery.

## Examples

``` r
if (FALSE) { # \dontrun{
Sys.setenv(JOBBOERSE_API_KEY = "jobboerse-jobsuche")
bunddev_auth_set("jobsuche", type = "api_key", env_var = "JOBBOERSE_API_KEY")
jobsuche_search_app(params = list(was = "data", size = 5), flatten = TRUE)
} # }
```
