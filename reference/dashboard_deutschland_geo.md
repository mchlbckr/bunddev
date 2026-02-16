# Get Dashboard Deutschland GeoJSON

Get Dashboard Deutschland GeoJSON

## Usage

``` r
dashboard_deutschland_geo(
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with GeoJSON metadata.

## Details

Returns GeoJSON data for Germany and the federal states. Official docs:
https://bundesapi.github.io/dashboard-deutschland-api/.

## Examples

``` r
if (FALSE) { # \dontrun{
dashboard_deutschland_geo(flatten = TRUE)
} # }
```
