# Fetch Tagesschau channels

Fetch Tagesschau channels

## Usage

``` r
tagesschau_channels(flatten = FALSE, flatten_mode = "json")
```

## Arguments

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

A tibble with the same columns as
[`tagesschau_homepage()`](https://buecker.ms/bunddev/reference/tagesschau_homepage.md),
restricted to channel entries.

- Scalar fields:

  One column per top-level scalar field returned by the endpoint.

- Nested fields:

  Kept as list-columns; for endpoints with `flatten` controls these can
  be transformed.

## Details

Lists the Tagesschau channels endpoint. API documentation:
<https://bundesapi.github.io/tagesschau-api/>.

## See also

[`tagesschau_news()`](https://buecker.ms/bunddev/reference/tagesschau_news.md)
and
[`tagesschau_homepage()`](https://buecker.ms/bunddev/reference/tagesschau_homepage.md).

Other Tagesschau:
[`tagesschau_homepage()`](https://buecker.ms/bunddev/reference/tagesschau_homepage.md),
[`tagesschau_news()`](https://buecker.ms/bunddev/reference/tagesschau_news.md),
[`tagesschau_search()`](https://buecker.ms/bunddev/reference/tagesschau_search.md)

## Examples

``` r
if (FALSE) { # \dontrun{
tagesschau_channels(flatten = TRUE)
} # }
```
