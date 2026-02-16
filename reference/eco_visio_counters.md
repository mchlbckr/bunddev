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

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per counter. Common columns:

- id:

  Counter identifier (character).

- name:

  Counter name/label (character).

- lat:

  Latitude (numeric).

- lon:

  Longitude (numeric).

- flow_ids:

  Flow/practice identifiers (list-column).

- raw:

  Original counter object (list-column).

## Details

The Eco-Visio API provides access to bicycle and pedestrian counter
data. This function returns all counters registered for a specific
organization. API documentation:
<https://github.com/bundesAPI/eco-visio-api>.

## See also

[`eco_visio_data()`](https://buecker.ms/bunddev/reference/eco_visio_data.md)
to retrieve measurement data for a counter.

Other Eco Visio:
[`eco_visio_data()`](https://buecker.ms/bunddev/reference/eco_visio_data.md)

## Examples

``` r
if (FALSE) { # \dontrun{
eco_visio_counters(4586)
} # }
```
