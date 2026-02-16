# List DiGA catalog entries

List DiGA catalog entries

## Usage

``` r
diga_catalog_entries(
  params = list(),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- params:

  Query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns.

## Value

A tibble containing DiGA catalog entry resources from the FHIR API.
Structure depends on `flatten` setting (see
[`diga_device_definitions()`](https://buecker.ms/bunddev/reference/diga_device_definitions.md)).
