# Fetch Tagesschau channels

Fetch Tagesschau channels

## Usage

``` r
tagesschau_channels(flatten = FALSE, flatten_mode = "json")
```

## Arguments

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with channels.

Includes `date_time` as POSIXct in Europe/Berlin.

## Details

Lists the Tagesschau channels endpoint. Official docs:
https://bundesapi.github.io/tagesschau-api/.

## See also

[`tagesschau_news()`](https://buecker.ms/bunddev/reference/tagesschau_news.md)
and
[`tagesschau_homepage()`](https://buecker.ms/bunddev/reference/tagesschau_homepage.md).

## Examples

``` r
if (FALSE) { # \dontrun{
tagesschau_channels(flatten = TRUE)
} # }
```
