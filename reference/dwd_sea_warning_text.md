# Fetch DWD sea warning text

Fetch DWD sea warning text

## Usage

``` r
dwd_sea_warning_text(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with the warning text.

## Details

Retrieves sea warning text from the DWD App API. Official docs:
https://dwd.api.bund.dev.

## See also

[`dwd_alpine_forecast_text()`](https://buecker.ms/bunddev/reference/dwd_alpine_forecast_text.md)
and
[`dwd_avalanche_warnings()`](https://buecker.ms/bunddev/reference/dwd_avalanche_warnings.md).

## Examples

``` r
if (FALSE) { # \dontrun{
dwd_sea_warning_text()
} # }
```
