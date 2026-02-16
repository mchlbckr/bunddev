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

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with station data.

Includes forecast time columns (`forecast_start_time`,
`forecast1_start_time`, `forecast2_start_time`) as POSIXct in
Europe/Berlin.

## Details

Retrieves station overview data from the DWD App API. Official docs:
https://dwd.api.bund.dev. Station IDs can be looked up via DWD opendata
resources or the API documentation.

## See also

[`dwd_crowd_reports()`](https://mchlbckr.github.io/bunddev/reference/dwd_crowd_reports.md)
and
[`dwd_warnings_nowcast()`](https://mchlbckr.github.io/bunddev/reference/dwd_warnings_nowcast.md).

## Examples

``` r
if (FALSE) { # \dontrun{
dwd_station_overview(c("10865", "G005"), flatten = TRUE)
} # }
```
