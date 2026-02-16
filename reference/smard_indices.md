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

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one column:

- timestamp:

  Available SMARD timestamp in milliseconds since epoch (numeric).

## Details

The SMARD API provides power market data published by the
Bundesnetzagentur. Use this helper to retrieve available timestamps for
a given filter/region and resolution. API documentation:
<https://smard.api.bund.dev>.

Note: The registry rate limit states that more than 60 requests per hour
are not permitted. Use `safe = TRUE` to respect the limit.

## See also

[`smard_timeseries()`](https://buecker.ms/bunddev/reference/smard_timeseries.md)
and
[`smard_table()`](https://buecker.ms/bunddev/reference/smard_table.md)
for data retrieval, and
[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
for parameter discovery.

Other SMARD:
[`smard_table()`](https://buecker.ms/bunddev/reference/smard_table.md),
[`smard_timeseries()`](https://buecker.ms/bunddev/reference/smard_timeseries.md)

## Examples

``` r
if (FALSE) { # \dontrun{
smard_indices(410, region = "DE", resolution = "hour")
} # }
```
