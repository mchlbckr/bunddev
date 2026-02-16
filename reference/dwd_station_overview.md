# Fetch DWD station overview data

Fetch DWD station overview data

## Usage

``` r
dwd_station_overview(
  station_ids,
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- station_ids:

  Station identifiers.

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

A tibble with one row per station id:

- station_id:

  Station id (character).

- forecast1:

  Forecast block 1 (list-column).

- forecast2:

  Forecast block 2 (list-column).

- forecast_start:

  Forecast start timestamp (character).

- forecast_start_time:

  Forecast start as `POSIXct` in Europe/Berlin.

- days:

  Daily forecast summaries (list-column).

- warnings:

  Warning entries (list-column).

- three_hour_summaries:

  Three-hour summaries (list-column).

- forecast1_start_time:

  `forecast1` start as `POSIXct`.

- forecast2_start_time:

  `forecast2` start as `POSIXct`.

## Details

Retrieves station overview data from the DWD App API. API documentation:
<https://dwd.api.bund.dev>. resources or the API documentation.

## See also

[`dwd_crowd_reports()`](https://buecker.ms/bunddev/reference/dwd_crowd_reports.md)
and
[`dwd_warnings_nowcast()`](https://buecker.ms/bunddev/reference/dwd_warnings_nowcast.md).

Other DWD:
[`dwd_alpine_forecast_text()`](https://buecker.ms/bunddev/reference/dwd_alpine_forecast_text.md),
[`dwd_avalanche_warnings()`](https://buecker.ms/bunddev/reference/dwd_avalanche_warnings.md),
[`dwd_coast_warnings()`](https://buecker.ms/bunddev/reference/dwd_coast_warnings.md),
[`dwd_crowd_reports()`](https://buecker.ms/bunddev/reference/dwd_crowd_reports.md),
[`dwd_municipality_warnings()`](https://buecker.ms/bunddev/reference/dwd_municipality_warnings.md),
[`dwd_sea_warning_text()`](https://buecker.ms/bunddev/reference/dwd_sea_warning_text.md),
[`dwd_warnings_nowcast()`](https://buecker.ms/bunddev/reference/dwd_warnings_nowcast.md)

## Examples

``` r
if (FALSE) { # \dontrun{
dwd_station_overview(c("10865", "G005"), flatten = TRUE)
} # }
```
