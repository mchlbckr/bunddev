# Search Tagesschau content

Search Tagesschau content

## Usage

``` r
tagesschau_search(
  search_text = NULL,
  page_size = NULL,
  result_page = NULL,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- search_text:

  Query string.

- page_size:

  Results per page.

- result_page:

  Result page index.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with search results.

Includes `date_time` as POSIXct in Europe/Berlin.

## Details

Searches Tagesschau content by free-text query. Official docs:
https://bundesapi.github.io/tagesschau-api/.

## See also

[`tagesschau_news()`](https://mchlbckr.github.io/bunddev/reference/tagesschau_news.md)
and
[`tagesschau_homepage()`](https://mchlbckr.github.io/bunddev/reference/tagesschau_homepage.md).

## Examples

``` r
if (FALSE) { # \dontrun{
tagesschau_search(search_text = "energie", page_size = 10, flatten = TRUE)
} # }
```
