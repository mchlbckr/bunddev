# Fetch DWD alpine forecast text

Fetch DWD alpine forecast text

## Usage

``` r
dwd_alpine_forecast_text(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A one-row tibble with one column `text` containing the forecast text.
Top-level scalar API fields are returned as tibble columns; nested
objects or arrays are kept in list-columns unless the function provides
`flatten` / `flatten_mode` controls.

## Details

Retrieves alpine forecast text from the DWD App API. API documentation:
<https://dwd.api.bund.dev>.

## See also

[`dwd_sea_warning_text()`](https://buecker.ms/bunddev/reference/dwd_sea_warning_text.md)
and
[`dwd_avalanche_warnings()`](https://buecker.ms/bunddev/reference/dwd_avalanche_warnings.md).

Other DWD:
[`dwd_avalanche_warnings()`](https://buecker.ms/bunddev/reference/dwd_avalanche_warnings.md),
[`dwd_coast_warnings()`](https://buecker.ms/bunddev/reference/dwd_coast_warnings.md),
[`dwd_crowd_reports()`](https://buecker.ms/bunddev/reference/dwd_crowd_reports.md),
[`dwd_municipality_warnings()`](https://buecker.ms/bunddev/reference/dwd_municipality_warnings.md),
[`dwd_sea_warning_text()`](https://buecker.ms/bunddev/reference/dwd_sea_warning_text.md),
[`dwd_station_overview()`](https://buecker.ms/bunddev/reference/dwd_station_overview.md),
[`dwd_warnings_nowcast()`](https://buecker.ms/bunddev/reference/dwd_warnings_nowcast.md)

## Examples

``` r
if (FALSE) { # \dontrun{
dwd_alpine_forecast_text()
} # }
```
