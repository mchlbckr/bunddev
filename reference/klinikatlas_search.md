# Search Bundes-Klinik-Atlas hospitals

Search Bundes-Klinik-Atlas hospitals

## Usage

``` r
klinikatlas_search(
  params = list(),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- params:

  Named list of upstream query parameters. Parameter names are forwarded
  unchanged and should match the OpenAPI spec, for example
  `tx_solr[searchlabel]`, `tx_solr[rows]`, or `tx_solr[icd]`.

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

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with one
row per search result and the nested API payload retained in
list-columns.

## Details

Searches hospitals using the documented Bundes-Klinik-Atlas search
endpoint. Parameter names are intentionally left in the upstream
bracketed form so they can be passed through unchanged. API
documentation: <https://github.com/bundesAPI/klinikatlas-api>.

## See also

Other Klinik Atlas:
[`klinikatlas_german_places()`](https://buecker.ms/bunddev/reference/klinikatlas_german_places.md),
[`klinikatlas_german_states()`](https://buecker.ms/bunddev/reference/klinikatlas_german_states.md),
[`klinikatlas_hospital_detail()`](https://buecker.ms/bunddev/reference/klinikatlas_hospital_detail.md),
[`klinikatlas_icd_codes()`](https://buecker.ms/bunddev/reference/klinikatlas_icd_codes.md),
[`klinikatlas_locations()`](https://buecker.ms/bunddev/reference/klinikatlas_locations.md),
[`klinikatlas_ops_codes()`](https://buecker.ms/bunddev/reference/klinikatlas_ops_codes.md),
[`klinikatlas_states()`](https://buecker.ms/bunddev/reference/klinikatlas_states.md)

## Examples

``` r
if (FALSE) { # \dontrun{
klinikatlas_search(params = list(
  "tx_solr[rows]" = 5,
  "tx_solr[start]" = 0,
  "tx_solr[searchlabel]" = "Berlin"
))
} # }
```
