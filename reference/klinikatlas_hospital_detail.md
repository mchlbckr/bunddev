# Fetch raw hospital detail HTML from Bundes-Klinik-Atlas

Fetch raw hospital detail HTML from Bundes-Klinik-Atlas

## Usage

``` r
klinikatlas_hospital_detail(id, params = list(), safe = TRUE, refresh = FALSE)
```

## Arguments

- id:

  Integer hospital identifier from
  [`klinikatlas_search()`](https://buecker.ms/bunddev/reference/klinikatlas_search.md).

- params:

  Optional named list of upstream query parameters such as
  `tx_tverzhospitaldata_show[department]` or `cHash`.

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

Character scalar containing the raw HTML response.

## Details

Returns the upstream HTML detail page as text. This wrapper
intentionally avoids HTML scraping so the package remains aligned with
the documented API surface. API documentation:
<https://github.com/bundesAPI/klinikatlas-api>.

## See also

Other Klinik Atlas:
[`klinikatlas_german_places()`](https://buecker.ms/bunddev/reference/klinikatlas_german_places.md),
[`klinikatlas_german_states()`](https://buecker.ms/bunddev/reference/klinikatlas_german_states.md),
[`klinikatlas_icd_codes()`](https://buecker.ms/bunddev/reference/klinikatlas_icd_codes.md),
[`klinikatlas_locations()`](https://buecker.ms/bunddev/reference/klinikatlas_locations.md),
[`klinikatlas_ops_codes()`](https://buecker.ms/bunddev/reference/klinikatlas_ops_codes.md),
[`klinikatlas_search()`](https://buecker.ms/bunddev/reference/klinikatlas_search.md),
[`klinikatlas_states()`](https://buecker.ms/bunddev/reference/klinikatlas_states.md)

## Examples

``` r
if (FALSE) { # \dontrun{
html <- klinikatlas_hospital_detail(2610)
substr(html, 1, 200)
} # }
```
