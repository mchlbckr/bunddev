# Fetch DWD alpine forecast text

Fetch DWD alpine forecast text

## Usage

``` r
dwd_alpine_forecast_text(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with the forecast text.

## Details

Retrieves alpine forecast text from the DWD App API. Official docs:
https://dwd.api.bund.dev.

## See also

[`dwd_sea_warning_text()`](https://buecker.ms/bunddev/reference/dwd_sea_warning_text.md)
and
[`dwd_avalanche_warnings()`](https://buecker.ms/bunddev/reference/dwd_avalanche_warnings.md).

## Examples

``` r
if (FALSE) { # \dontrun{
dwd_alpine_forecast_text()
} # }
```
