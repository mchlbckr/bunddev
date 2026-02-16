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

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with news items.

Includes `date_time` as POSIXct in Europe/Berlin.

## Details

Returns current news items with optional filters for region or ressort.
Official docs: https://bundesapi.github.io/tagesschau-api/.

## See also

[`tagesschau_homepage()`](https://mchlbckr.github.io/bunddev/reference/tagesschau_homepage.md)
and
[`tagesschau_search()`](https://mchlbckr.github.io/bunddev/reference/tagesschau_search.md).

## Examples

``` r
if (FALSE) { # \dontrun{
tagesschau_news(ressort = "inland", flatten = TRUE)
} # }
```
