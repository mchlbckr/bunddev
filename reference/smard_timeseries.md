# Fetch SMARD timeseries data

Fetch SMARD timeseries data

## Usage

``` r
smard_timeseries(
  filter,
  region = "DE",
  resolution = "hour",
  timestamp,
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- filter:

  Filter id.

- region:

  Region code.

- resolution:

  Data resolution.

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

A tibble with one row per time point:

- timestamp:

  Timestamp in milliseconds since epoch (numeric).

- time:

  Timestamp as `POSIXct` in Europe/Berlin.

- value:

  Series value for the selected filter/region (numeric).

## Details

Returns a tidy time series for a single filter/region. Use
[`smard_indices()`](https://buecker.ms/bunddev/reference/smard_indices.md)
to obtain a valid timestamp. API documentation:
<https://smard.api.bund.dev>.

## See also

[`smard_indices()`](https://buecker.ms/bunddev/reference/smard_indices.md)
for timestamps and
[`smard_table()`](https://buecker.ms/bunddev/reference/smard_table.md)
for table output.

Other SMARD:
[`smard_indices()`](https://buecker.ms/bunddev/reference/smard_indices.md),
[`smard_table()`](https://buecker.ms/bunddev/reference/smard_table.md)

## Examples

``` r
if (FALSE) { # \dontrun{
indices <- smard_indices(410, region = "DE", resolution = "hour")
smard_timeseries(410, region = "DE", resolution = "hour", timestamp = indices$timestamp[[1]])
} # }
```
