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

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with search results.

## Details

The Handelsregister search is provided via a public web form. This
helper automates the form flow and parses the result table into a tidy
tibble. Official docs: https://github.com/bundesAPI/handelsregister.

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
