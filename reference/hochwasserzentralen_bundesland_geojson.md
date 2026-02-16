# Get Bundesland GeoJSON boundaries

Get Bundesland GeoJSON boundaries

## Usage

``` r
hochwasserzentralen_bundesland_geojson(
  version,
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- version:

  GeoJSON version identifier (e.g., "20211130").

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

A tibble with GeoJSON metadata and feature list-columns.

## Details

Returns GeoJSON boundaries for Bundeslaender and connected regions from
the hochwasserzentralen.de portal. Official docs:
https://bundesapi.github.io/hochwasserzentralen-api/.

## Examples

``` r
if (FALSE) { # \dontrun{
hochwasserzentralen_bundesland_geojson("20211130", flatten = TRUE)
} # }
```
