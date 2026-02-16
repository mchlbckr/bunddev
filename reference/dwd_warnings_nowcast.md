# Fetch DWD nowcast warnings

Fetch DWD nowcast warnings

## Usage

``` r
dwd_warnings_nowcast(
  language = c("de", "en"),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- language:

  Language code ("de" or "en").

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

A tibble with one row per warning:

- type:

  Warning type code (numeric).

- level:

  Warning severity level (numeric).

- start:

  Start timestamp in milliseconds (numeric).

- start_time:

  Parsed start time (POSIXct).

- end:

  End timestamp in milliseconds (numeric).

- end_time:

  Parsed end time (POSIXct).

- description:

  Warning description HTML (character).

- description_text:

  Warning description plain text (character).

- event:

  Event name (character).

- headline:

  Warning headline (character).

- regions:

  Affected regions (list-column).

- urls:

  Related URLs (list-column).

- is_vorabinfo:

  Whether this is a preliminary warning (logical).

With `flatten = TRUE`, the list-columns are transformed according to
`flatten_mode`.

## Details

Retrieves nowcast weather warnings from the DWD App API. API
documentation: <https://dwd.api.bund.dev>.

## See also

[`dwd_municipality_warnings()`](https://buecker.ms/bunddev/reference/dwd_municipality_warnings.md)
and
[`dwd_coast_warnings()`](https://buecker.ms/bunddev/reference/dwd_coast_warnings.md).

Other DWD:
[`dwd_alpine_forecast_text()`](https://buecker.ms/bunddev/reference/dwd_alpine_forecast_text.md),
[`dwd_avalanche_warnings()`](https://buecker.ms/bunddev/reference/dwd_avalanche_warnings.md),
[`dwd_coast_warnings()`](https://buecker.ms/bunddev/reference/dwd_coast_warnings.md),
[`dwd_crowd_reports()`](https://buecker.ms/bunddev/reference/dwd_crowd_reports.md),
[`dwd_municipality_warnings()`](https://buecker.ms/bunddev/reference/dwd_municipality_warnings.md),
[`dwd_sea_warning_text()`](https://buecker.ms/bunddev/reference/dwd_sea_warning_text.md),
[`dwd_station_overview()`](https://buecker.ms/bunddev/reference/dwd_station_overview.md)

## Examples

``` r
if (FALSE) { # \dontrun{
dwd_warnings_nowcast(language = "de", flatten = TRUE)
} # }
```
