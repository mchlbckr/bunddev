# Get a NINA warning (GeoJSON)

Get a NINA warning (GeoJSON)

## Usage

``` r
nina_warning_geojson(identifier, safe = TRUE, refresh = FALSE)
```

## Arguments

- identifier:

  Warning identifier.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with geojson payload.

## Details

Returns a warning in GeoJSON format.
