# Fetch DWD crowd reports

Fetch DWD crowd reports

## Usage

``` r
dwd_crowd_reports(
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

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

A tibble with one row per crowd report:

- meldung_id:

  Report identifier (numeric).

- timestamp:

  Report timestamp in milliseconds (numeric).

- timestamp_time:

  Parsed report time (POSIXct).

- lat:

  Latitude (character).

- lon:

  Longitude (character).

- place:

  Place name (character).

- category:

  Weather category (character).

- auspraegung:

  Severity/manifestation (character).

- zusatz_attribute:

  Additional attributes (list-column).

## Details

Retrieves crowd-sourced weather reports from the DWD App API. API
documentation: <https://dwd.api.bund.dev>.

## See also

[`dwd_station_overview()`](https://buecker.ms/bunddev/reference/dwd_station_overview.md)
and
[`dwd_warnings_nowcast()`](https://buecker.ms/bunddev/reference/dwd_warnings_nowcast.md).

Other DWD:
[`dwd_alpine_forecast_text()`](https://buecker.ms/bunddev/reference/dwd_alpine_forecast_text.md),
[`dwd_avalanche_warnings()`](https://buecker.ms/bunddev/reference/dwd_avalanche_warnings.md),
[`dwd_coast_warnings()`](https://buecker.ms/bunddev/reference/dwd_coast_warnings.md),
[`dwd_municipality_warnings()`](https://buecker.ms/bunddev/reference/dwd_municipality_warnings.md),
[`dwd_sea_warning_text()`](https://buecker.ms/bunddev/reference/dwd_sea_warning_text.md),
[`dwd_station_overview()`](https://buecker.ms/bunddev/reference/dwd_station_overview.md),
[`dwd_warnings_nowcast()`](https://buecker.ms/bunddev/reference/dwd_warnings_nowcast.md)

## Examples

``` r
if (FALSE) { # \dontrun{
dwd_crowd_reports(flatten = TRUE)
} # }
```
