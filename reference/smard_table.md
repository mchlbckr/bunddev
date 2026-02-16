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

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble of table values.

Includes a `time` column with POSIXct timestamps in Europe/Berlin.

## Details

Returns table-style SMARD data for a single timestamp. Use
[`smard_indices()`](https://mchlbckr.github.io/bunddev/reference/smard_indices.md)
to obtain a valid timestamp. Official docs: https://smard.api.bund.dev.

## See also

[`smard_indices()`](https://mchlbckr.github.io/bunddev/reference/smard_indices.md)
for timestamps and
[`smard_timeseries()`](https://mchlbckr.github.io/bunddev/reference/smard_timeseries.md)
for time series.

## Examples

``` r
if (FALSE) { # \dontrun{
indices <- smard_indices(410, region = "DE", resolution = "hour")
smard_table(410, region = "DE", timestamp = indices$timestamp[[1]])
} # }
```
