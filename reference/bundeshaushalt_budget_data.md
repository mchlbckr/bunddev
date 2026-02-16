# Query Bundeshaushalt budget data

Query Bundeshaushalt budget data

## Usage

``` r
bundeshaushalt_budget_data(
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

  year

  :   Budget year (integer, required).

  account

  :   Account type (`"income"` or `"expenses"`, required).

  quota

  :   Target value mode, e.g. planned/actual values (character).

  unit

  :   Budget unit/granularity level (character).

  id

  :   Optional budget node id to drill into a specific subtree
      (character).

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

A one-row tibble with budget metadata and nested payloads:

- account:

  Requested account type (character).

- entity:

  Entity label from the API response (character).

- level_cur:

  Current hierarchy level (integer).

- level_max:

  Maximum hierarchy level (integer).

- modify_date:

  Upstream modification date (character).

- quota:

  Quota/target mode (character).

- timestamp:

  Response timestamp in milliseconds (numeric).

- timestamp_time:

  Response timestamp as `POSIXct` in Europe/Berlin.

- unit:

  Selected unit/granularity (character).

- year:

  Budget year (integer).

- details:

  Detailed budget rows (list-column).

- children:

  Child nodes in the budget hierarchy (list-column).

- parents:

  Parent nodes in the hierarchy (list-column).

- related:

  Related nodes from the API response (list-column).

## Details

The Bundeshaushalt API provides budget data for federal income and
expenses. Required query parameters are `year` and `account`. API
documentation: <https://github.com/bundesAPI/bundeshaushalt-api>.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect parameter metadata from the OpenAPI spec.

## Examples

``` r
if (FALSE) { # \dontrun{
bundeshaushalt_budget_data(params = list(year = 2021, account = "expenses"))
} # }
```
