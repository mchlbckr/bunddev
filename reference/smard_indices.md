# List available SMARD timestamps

List available SMARD timestamps

## Usage

``` r
smard_indices(
  filter,
  region = "DE",
  resolution = "hour",
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

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble of timestamps.

## Details

The SMARD API provides power market data published by the
Bundesnetzagentur. Use this helper to retrieve available timestamps for
a given filter/region and resolution. Official docs:
https://smard.api.bund.dev.

Note: The registry rate limit states that more than 60 requests per hour
are not permitted. Use `safe = TRUE` to respect the limit.

## See also

[`smard_timeseries()`](https://buecker.ms/bunddev/reference/smard_timeseries.md)
and
[`smard_table()`](https://buecker.ms/bunddev/reference/smard_table.md)
for data retrieval, and
[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
for parameter discovery.

## Examples

``` r
if (FALSE) { # \dontrun{
smard_indices(410, region = "DE", resolution = "hour")
} # }
```
