# Fetch Tagesschau homepage items

Fetch Tagesschau homepage items

## Usage

``` r
tagesschau_homepage(flatten = FALSE, flatten_mode = "json")
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

A tibble with one row per item:

- section:

  Feed section, e.g. "news" or "regional" (character).

- sophora_id:

  Sophora CMS identifier (character).

- external_id:

  External identifier (character).

- title:

  Article title (character).

- date:

  Publication date string (character).

- date_time:

  Parsed publication date (POSIXct).

- topline:

  Topline/kicker text (character).

- first_sentence:

  First sentence of the article (character).

- details:

  API details URL (character).

- detailsweb:

  Web details URL (character).

- share_url:

  Share URL (character).

- update_check_url:

  Update-check URL (character).

- region_id:

  Region identifier (character).

- ressort:

  Editorial section/ressort (character).

- type:

  Content type (character).

- breaking_news:

  Whether the item is breaking news (logical).

- copyright:

  Copyright notice (character).

- alttext:

  Image alt text (character).

- teaser_image:

  Teaser image metadata (list-column).

- tracking:

  Tracking metadata (list-column).

- tags:

  Associated tags (list-column).

- images:

  Image collection (list-column).

- streams:

  Media streams (list-column).

- geotags:

  Geographic tags (list-column).

- branding_image:

  Branding image metadata (list-column).

- first_frame:

  First video frame metadata (list-column).

With `flatten = TRUE`, the list-columns are transformed according to
`flatten_mode`.

## Details

Fetches the Tagesschau homepage feed as provided by the ARD Tagesschau
API. API documentation: <https://bundesapi.github.io/tagesschau-api/>.

Note: The registry rate limit allows up to 60 requests per hour. Usage
of content is restricted to private, non-commercial use unless otherwise
stated by the source (see Tagesschau CC license notes).

## See also

[`tagesschau_news()`](https://buecker.ms/bunddev/reference/tagesschau_news.md),
[`tagesschau_search()`](https://buecker.ms/bunddev/reference/tagesschau_search.md),
and
[`tagesschau_channels()`](https://buecker.ms/bunddev/reference/tagesschau_channels.md).

Other Tagesschau:
[`tagesschau_channels()`](https://buecker.ms/bunddev/reference/tagesschau_channels.md),
[`tagesschau_news()`](https://buecker.ms/bunddev/reference/tagesschau_news.md),
[`tagesschau_search()`](https://buecker.ms/bunddev/reference/tagesschau_search.md)

## Examples

``` r
if (FALSE) { # \dontrun{
tagesschau_homepage(flatten = TRUE)
} # }
```
