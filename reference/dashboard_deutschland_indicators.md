# Query Dashboard Deutschland indicators

Query Dashboard Deutschland indicators

## Usage

``` r
dashboard_deutschland_indicators(ids = NULL, safe = TRUE, refresh = FALSE)
```

## Arguments

- ids:

  Indicator ids, semicolon-separated or as a character vector.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with indicator data.

Includes `date_time` as POSIXct in Europe/Berlin.

## Details

Returns indicator data for the specified ids. Official docs:
https://bundesapi.github.io/dashboard-deutschland-api/.

## Examples

``` r
if (FALSE) { # \dontrun{
dashboard_deutschland_indicators("tile_1667811574092")
} # }
```
