# List state names documents

List state names documents

## Usage

``` r
travelwarning_state_names(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with state-name entries and common metadata columns as returned
by
[`travelwarning_warnings()`](https://buecker.ms/bunddev/reference/travelwarning_warnings.md).

- Scalar fields:

  One column per top-level scalar field returned by the endpoint.

- Nested fields:

  Kept as list-columns; for endpoints with `flatten` controls these can
  be transformed.

## Details

Returns documents with state name information. API documentation:
<https://travelwarning.api.bund.dev>.

## See also

Other Travelwarning:
[`travelwarning_healthcare()`](https://buecker.ms/bunddev/reference/travelwarning_healthcare.md),
[`travelwarning_representatives_country()`](https://buecker.ms/bunddev/reference/travelwarning_representatives_country.md),
[`travelwarning_representatives_germany()`](https://buecker.ms/bunddev/reference/travelwarning_representatives_germany.md),
[`travelwarning_warning()`](https://buecker.ms/bunddev/reference/travelwarning_warning.md),
[`travelwarning_warnings()`](https://buecker.ms/bunddev/reference/travelwarning_warnings.md)

## Examples

``` r
if (FALSE) { # \dontrun{
travelwarning_state_names()
} # }
```
