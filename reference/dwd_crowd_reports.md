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

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with crowd reports.

Includes `timestamp_time` as POSIXct in Europe/Berlin.

## Details

Retrieves crowd-sourced weather reports from the DWD App API. Official
docs: https://dwd.api.bund.dev.

## See also

[`dwd_station_overview()`](https://buecker.ms/bunddev/reference/dwd_station_overview.md)
and
[`dwd_warnings_nowcast()`](https://buecker.ms/bunddev/reference/dwd_warnings_nowcast.md).

## Examples

``` r
if (FALSE) { # \dontrun{
dwd_crowd_reports(flatten = TRUE)
} # }
```
