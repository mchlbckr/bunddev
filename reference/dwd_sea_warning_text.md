# Fetch DWD sea warning text

Fetch DWD sea warning text

## Usage

``` r
dwd_sea_warning_text(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A one-row tibble with one column `text` containing the warning text.

## Details

Retrieves sea warning text from the DWD App API. API documentation:
<https://dwd.api.bund.dev>.

## See also

[`dwd_alpine_forecast_text()`](https://buecker.ms/bunddev/reference/dwd_alpine_forecast_text.md)
and
[`dwd_avalanche_warnings()`](https://buecker.ms/bunddev/reference/dwd_avalanche_warnings.md).

Other DWD:
[`dwd_alpine_forecast_text()`](https://buecker.ms/bunddev/reference/dwd_alpine_forecast_text.md),
[`dwd_avalanche_warnings()`](https://buecker.ms/bunddev/reference/dwd_avalanche_warnings.md),
[`dwd_coast_warnings()`](https://buecker.ms/bunddev/reference/dwd_coast_warnings.md),
[`dwd_crowd_reports()`](https://buecker.ms/bunddev/reference/dwd_crowd_reports.md),
[`dwd_municipality_warnings()`](https://buecker.ms/bunddev/reference/dwd_municipality_warnings.md),
[`dwd_station_overview()`](https://buecker.ms/bunddev/reference/dwd_station_overview.md),
[`dwd_warnings_nowcast()`](https://buecker.ms/bunddev/reference/dwd_warnings_nowcast.md)

## Examples

``` r
if (FALSE) { # \dontrun{
dwd_sea_warning_text()
} # }
```
