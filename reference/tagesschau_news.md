# Fetch Tagesschau news items

Fetch Tagesschau news items

## Usage

``` r
tagesschau_news(
  regions = NULL,
  ressort = NULL,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- regions:

  Optional region ids.

- ressort:

  Optional ressort filter.

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
filtered by optional region/ressort parameters.

## Details

Returns current news items with optional filters for region or ressort.
API documentation: <https://bundesapi.github.io/tagesschau-api/>.

## See also

[`tagesschau_homepage()`](https://buecker.ms/bunddev/reference/tagesschau_homepage.md)
and
[`tagesschau_search()`](https://buecker.ms/bunddev/reference/tagesschau_search.md).

Other Tagesschau:
[`tagesschau_channels()`](https://buecker.ms/bunddev/reference/tagesschau_channels.md),
[`tagesschau_homepage()`](https://buecker.ms/bunddev/reference/tagesschau_homepage.md),
[`tagesschau_search()`](https://buecker.ms/bunddev/reference/tagesschau_search.md)

## Examples

``` r
if (FALSE) { # \dontrun{
tagesschau_news(ressort = "inland", flatten = TRUE)
} # }
```
