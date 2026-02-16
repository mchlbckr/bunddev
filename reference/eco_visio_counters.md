# List Eco-Visio counters for an organization

List Eco-Visio counters for an organization

## Usage

``` r
eco_visio_counters(id_organisme, safe = TRUE, refresh = FALSE)
```

## Arguments

- id_organisme:

  Organization ID (e.g., 4586 for Bike Count Display).

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with counter metadata.

## Details

The Eco-Visio API provides access to bicycle and pedestrian counter
data. This function returns all counters registered for a specific
organization. Official docs: https://github.com/bundesAPI/eco-visio-api.

## See also

[`eco_visio_data()`](https://buecker.ms/bunddev/reference/eco_visio_data.md)
to retrieve measurement data for a counter.

## Examples

``` r
if (FALSE) { # \dontrun{
eco_visio_counters(4586)
} # }
```
