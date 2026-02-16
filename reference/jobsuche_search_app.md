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

  Named list of query parameters:

  was

  :   Free-text job/keyword query (character).

  wo

  :   Location query (character).

  berufsfeld

  :   Occupational field filter (character).

  page

  :   Page index (integer).

  size

  :   Number of results per page (integer).

  arbeitgeber

  :   Employer filter (character).

  veroeffentlichtseit

  :   Only offers published within N days (integer).

  zeitarbeit

  :   Filter temporary-agency postings (`TRUE`/`FALSE`).

  angebotsart

  :   Offer type code(s), semicolon-separated (integer/character).

  befristung

  :   Contract duration code(s), semicolon-separated
      (integer/character).

  arbeitszeit

  :   Work time model code(s), semicolon-separated (character).

  behinderung

  :   Accessibility/disability filter (`TRUE`/`FALSE`).

  corona

  :   Only postings with corona flag (`TRUE`/`FALSE`).

  umkreis

  :   Radius in kilometers around `wo` (integer).

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

A tibble with the same columns as
[`jobsuche_search()`](https://buecker.ms/bunddev/reference/jobsuche_search.md).

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

Other Jobsuche:
[`jobsuche_logo()`](https://buecker.ms/bunddev/reference/jobsuche_logo.md),
[`jobsuche_search()`](https://buecker.ms/bunddev/reference/jobsuche_search.md)

## Examples

``` r
if (FALSE) { # \dontrun{
Sys.setenv(JOBBOERSE_API_KEY = "jobboerse-jobsuche")
bunddev_auth_set("jobsuche", type = "api_key", env_var = "JOBBOERSE_API_KEY")
jobsuche_search_app(params = list(was = "data", size = 5), flatten = TRUE)
} # }
```
