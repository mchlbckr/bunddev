# Fetch SMARD table data

Fetch SMARD table data

## Usage

``` r
smard_table(filter, region = "DE", timestamp, safe = TRUE, refresh = FALSE)
```

## Arguments

- filter:

  Filter id.

- region:

  Region code.

- timestamp:

  Timestamp from indices (ms), POSIXct, or Date.

  Timestamps are interpreted in the Europe/Berlin timezone.

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per returned value/version:

- timestamp:

  Timestamp in milliseconds since epoch (numeric).

- time:

  Timestamp as `POSIXct` in Europe/Berlin.

- value:

  Reported value (numeric).

- name:

  Version/series label when provided by the API (character).

## Details

Returns table-style SMARD data for a single timestamp. Use
[`smard_indices()`](https://buecker.ms/bunddev/reference/smard_indices.md)
to obtain a valid timestamp. API documentation:
<https://smard.api.bund.dev>.

## See also

[`smard_indices()`](https://buecker.ms/bunddev/reference/smard_indices.md)
for timestamps and
[`smard_timeseries()`](https://buecker.ms/bunddev/reference/smard_timeseries.md)
for time series.

Other SMARD:
[`smard_indices()`](https://buecker.ms/bunddev/reference/smard_indices.md),
[`smard_timeseries()`](https://buecker.ms/bunddev/reference/smard_timeseries.md)

## Examples

``` r
if (FALSE) { # \dontrun{
indices <- smard_indices(410, region = "DE", resolution = "hour")
smard_table(410, region = "DE", timestamp = indices$timestamp[[1]])
} # }
```
