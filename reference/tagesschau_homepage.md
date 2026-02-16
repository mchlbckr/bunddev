# Fetch Tagesschau homepage items

Fetch Tagesschau homepage items

## Usage

``` r
tagesschau_homepage(flatten = FALSE, flatten_mode = "json")
```

## Arguments

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with homepage items.

Includes `date_time` as POSIXct in Europe/Berlin.

## Details

Fetches the Tagesschau homepage feed as provided by the ARD Tagesschau
API. Official docs: https://bundesapi.github.io/tagesschau-api/.

Note: The registry rate limit allows up to 60 requests per hour. Usage
of content is restricted to private, non-commercial use unless otherwise
stated by the source (see Tagesschau CC license notes).

## See also

[`tagesschau_news()`](https://mchlbckr.github.io/bunddev/reference/tagesschau_news.md),
[`tagesschau_search()`](https://mchlbckr.github.io/bunddev/reference/tagesschau_search.md),
and
[`tagesschau_channels()`](https://mchlbckr.github.io/bunddev/reference/tagesschau_channels.md).

## Examples

``` r
if (FALSE) { # \dontrun{
tagesschau_homepage(flatten = TRUE)
} # }
```
