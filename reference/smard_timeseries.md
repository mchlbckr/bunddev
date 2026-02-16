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

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble of time series values.

Includes a `time` column with POSIXct timestamps in Europe/Berlin.

## Details

Returns a tidy time series for a single filter/region. Use
[`smard_indices()`](https://mchlbckr.github.io/bunddev/reference/smard_indices.md)
to obtain a valid timestamp. Official docs: https://smard.api.bund.dev.

## See also

[`smard_indices()`](https://mchlbckr.github.io/bunddev/reference/smard_indices.md)
for timestamps and
[`smard_table()`](https://mchlbckr.github.io/bunddev/reference/smard_table.md)
for table output.

## Examples

``` r
if (FALSE) { # \dontrun{
indices <- smard_indices(410, region = "DE", resolution = "hour")
smard_timeseries(410, region = "DE", resolution = "hour", timestamp = indices$timestamp[[1]])
} # }
```
