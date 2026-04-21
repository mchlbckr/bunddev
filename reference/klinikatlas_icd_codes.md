# List ICD codes from Bundes-Klinik-Atlas

List ICD codes from Bundes-Klinik-Atlas

## Usage

``` r
klinikatlas_icd_codes(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with one
row per ICD code.

## Details

Returns ICD code metadata used by the Bundes-Klinik-Atlas search UI. API
documentation: <https://github.com/bundesAPI/klinikatlas-api>.

## See also

Other Klinik Atlas:
[`klinikatlas_german_places()`](https://buecker.ms/bunddev/reference/klinikatlas_german_places.md),
[`klinikatlas_german_states()`](https://buecker.ms/bunddev/reference/klinikatlas_german_states.md),
[`klinikatlas_hospital_detail()`](https://buecker.ms/bunddev/reference/klinikatlas_hospital_detail.md),
[`klinikatlas_locations()`](https://buecker.ms/bunddev/reference/klinikatlas_locations.md),
[`klinikatlas_ops_codes()`](https://buecker.ms/bunddev/reference/klinikatlas_ops_codes.md),
[`klinikatlas_search()`](https://buecker.ms/bunddev/reference/klinikatlas_search.md),
[`klinikatlas_states()`](https://buecker.ms/bunddev/reference/klinikatlas_states.md)

## Examples

``` r
if (FALSE) { # \dontrun{
klinikatlas_icd_codes()
} # }
```
