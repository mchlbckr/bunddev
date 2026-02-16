# List air quality measurements

List air quality measurements

## Usage

``` r
luftqualitaet_airquality(params = list(), safe = TRUE, refresh = FALSE)
```

## Arguments

- params:

  Query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with air quality data.

## Details

The Luftqualitaet API provides air quality data and metadata from the
Umweltbundesamt. Use query parameters to filter by date/time and
station. Official docs: https://luftqualitaet.api.bund.dev.

## See also

[`luftqualitaet_measures()`](https://buecker.ms/bunddev/reference/luftqualitaet_measures.md)
for measurement metadata and
[`luftqualitaet_components()`](https://buecker.ms/bunddev/reference/luftqualitaet_components.md)
for pollutant components.

## Examples

``` r
if (FALSE) { # \dontrun{
luftqualitaet_airquality(params = list(
  date_from = "2024-01-01",
  date_to = "2024-01-02"
))
} # }
```
