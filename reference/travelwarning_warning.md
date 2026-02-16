# Get a travel warning by content id

Get a travel warning by content id

## Usage

``` r
travelwarning_warning(content_id, safe = TRUE, refresh = FALSE)
```

## Arguments

- content_id:

  Travel warning content id.

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per warning content block and the same column
structure as
[`travelwarning_warnings()`](https://buecker.ms/bunddev/reference/travelwarning_warnings.md).

## Details

Returns the full travel warning content, including HTML blocks. API
documentation: <https://travelwarning.api.bund.dev>.

## See also

[`travelwarning_warnings()`](https://buecker.ms/bunddev/reference/travelwarning_warnings.md)
to list available ids.

Other Travelwarning:
[`travelwarning_healthcare()`](https://buecker.ms/bunddev/reference/travelwarning_healthcare.md),
[`travelwarning_representatives_country()`](https://buecker.ms/bunddev/reference/travelwarning_representatives_country.md),
[`travelwarning_representatives_germany()`](https://buecker.ms/bunddev/reference/travelwarning_representatives_germany.md),
[`travelwarning_state_names()`](https://buecker.ms/bunddev/reference/travelwarning_state_names.md),
[`travelwarning_warnings()`](https://buecker.ms/bunddev/reference/travelwarning_warnings.md)

## Examples

``` r
if (FALSE) { # \dontrun{
warnings <- travelwarning_warnings()
travelwarning_warning(warnings$content_id[[1]])
} # }
```
