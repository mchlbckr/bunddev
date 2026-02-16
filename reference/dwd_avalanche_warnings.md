# Fetch DWD avalanche warnings

Fetch DWD avalanche warnings

## Usage

``` r
dwd_avalanche_warnings(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with avalanche data.

## Details

Retrieves avalanche warnings from the DWD App API. Official docs:
https://dwd.api.bund.dev.

## See also

[`dwd_alpine_forecast_text()`](https://buecker.ms/bunddev/reference/dwd_alpine_forecast_text.md)
and
[`dwd_sea_warning_text()`](https://buecker.ms/bunddev/reference/dwd_sea_warning_text.md).

## Examples

``` r
if (FALSE) { # \dontrun{
dwd_avalanche_warnings()
} # }
```
