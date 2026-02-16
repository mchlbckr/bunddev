# Search the Handelsregister portal

This adapter scrapes the public Handelsregister search form because no
official OpenAPI specification is available for this service.

## Usage

``` r
handelsregister_search(
  schlagwoerter,
  schlagwort_optionen = c("all", "min", "exact"),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- schlagwoerter:

  Search terms.

- schlagwort_optionen:

  Keyword options.

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

A tibble with one row per register entry:

- name:

  Company/entity name (character).

- court:

  Register court and register label (character).

- register_num:

  Extracted register number (character).

- state:

  Federal state (character).

- status:

  Status text from the listing (character).

- status_current:

  Uppercase status code derived from `status` (character).

- documents_text:

  Document summary text (character).

- documents_count:

  Number of linked documents (integer).

- documents_links:

  Document URLs (list-column of character vectors).

- history:

  Additional parsed history tokens (list-column).

## Details

The Handelsregister search is provided via a public web form. This
helper automates the form flow and parses the result table into a tidy
tibble. API documentation:
<https://github.com/bundesAPI/handelsregister>.

The registry notes that more than 60 requests per hour may violate the
terms of use. Use `safe = TRUE` to respect the built-in rate limiting.

## See also

[`bunddev_rate_limit_get()`](https://buecker.ms/bunddev/reference/bunddev_rate_limit_get.md)
to inspect the configured limit.

## Examples

``` r
if (FALSE) { # \dontrun{
handelsregister_search("Deutsche Bahn", schlagwort_optionen = "all")
} # }
```
