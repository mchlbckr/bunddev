# List food and product warnings

List food and product warnings

## Usage

``` r
lebensmittelwarnung_warnings(
  food = list(),
  products = list(),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- food:

  Optional request options for food warnings (rows, start, sort, fq).

- products:

  Optional request options for product warnings (rows, start, sort, fq).

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

A tibble with one row per warning:

- type:

  Warning type from the source index (character).

- archived:

  Whether the warning is archived (`TRUE`/`FALSE`).

- id:

  Warning identifier (integer).

- link:

  Link to the warning details page (character).

- title:

  Warning title (character).

- warning:

  Warning text/summary (character).

- affected_states:

  Affected German states (list-column).

- product:

  Structured product details (list-column).

- rapex_information:

  RAPEX metadata when present (list-column).

- safety_information:

  Additional safety metadata (list-column).

- published_date:

  Published timestamp in milliseconds since epoch (numeric).

- published_date_time:

  Published timestamp as `POSIXct` in Europe/Berlin.

- num_found:

  Total number of matching warnings in the response (integer).

## Details

The Lebensmittelwarnungen API returns German food and product safety
warnings. Requests are sent as JSON to the `warnings/merged` endpoint.
API documentation: <https://lebensmittelwarnung.api.bund.dev>.
https://github.com/bundesAPI/lebensmittelwarnung-api.

The API expects an `Authorization` header. By default the adapter uses
the public key documented in the OpenAPI spec. Override it with
[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
if needed.

## See also

[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
to configure the authorization header.

## Examples

``` r
if (FALSE) { # \dontrun{
lebensmittelwarnung_warnings(food = list(rows = 10), products = list(rows = 0))
} # }
```
