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

A tibble with one row per item and columns: `section`, `sophora_id`,
`external_id`, `title`, `date`, `date_time`, `topline`,
`first_sentence`, `details`, `detailsweb`, `share_url`,
`update_check_url`, `region_id`, `ressort`, `type`, `breaking_news`,
`copyright`, `alttext`, and list-columns `teaser_image`, `tracking`,
`tags`, `images`, `streams`, `geotags`, `branding_image`, `first_frame`.

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
