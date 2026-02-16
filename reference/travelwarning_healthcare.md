# List healthcare documents

List healthcare documents

## Usage

``` r
travelwarning_healthcare(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with healthcare entries and common metadata columns as returned
by
[`travelwarning_warnings()`](https://buecker.ms/bunddev/reference/travelwarning_warnings.md).

## Details

Returns healthcare documents provided by the Auswaertiges Amt. API
documentation: <https://travelwarning.api.bund.dev>.

## See also

Other Travelwarning:
[`travelwarning_representatives_country()`](https://buecker.ms/bunddev/reference/travelwarning_representatives_country.md),
[`travelwarning_representatives_germany()`](https://buecker.ms/bunddev/reference/travelwarning_representatives_germany.md),
[`travelwarning_state_names()`](https://buecker.ms/bunddev/reference/travelwarning_state_names.md),
[`travelwarning_warning()`](https://buecker.ms/bunddev/reference/travelwarning_warning.md),
[`travelwarning_warnings()`](https://buecker.ms/bunddev/reference/travelwarning_warnings.md)

## Examples

``` r
if (FALSE) { # \dontrun{
travelwarning_healthcare()
} # }
```
