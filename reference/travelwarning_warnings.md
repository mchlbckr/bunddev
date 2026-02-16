# List travel warnings

List travel warnings

## Usage

``` r
travelwarning_warnings(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per warning entry. Common columns include
`content_id`, `parent_content_id`, `response_country`,
`response_last_modified`, `response_last_modified_time`,
`last_modified_time`, and `effective_time`, plus additional warning
fields mapped from the upstream payload.

## Details

The travelwarning API provides travel and safety information from the
Auswaertiges Amt. This endpoint returns a list of all travel warnings
with metadata. API documentation: <https://travelwarning.api.bund.dev>.

## See also

[`travelwarning_warning()`](https://buecker.ms/bunddev/reference/travelwarning_warning.md)
for full details of a single warning.

Other Travelwarning:
[`travelwarning_healthcare()`](https://buecker.ms/bunddev/reference/travelwarning_healthcare.md),
[`travelwarning_representatives_country()`](https://buecker.ms/bunddev/reference/travelwarning_representatives_country.md),
[`travelwarning_representatives_germany()`](https://buecker.ms/bunddev/reference/travelwarning_representatives_germany.md),
[`travelwarning_state_names()`](https://buecker.ms/bunddev/reference/travelwarning_state_names.md),
[`travelwarning_warning()`](https://buecker.ms/bunddev/reference/travelwarning_warning.md)

## Examples

``` r
if (FALSE) { # \dontrun{
travelwarning_warnings()
} # }
```
