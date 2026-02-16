# List DiGA questionnaire responses

List DiGA questionnaire responses

## Usage

``` r
diga_questionnaire_responses(
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

A tibble containing DiGA questionnaire response resources from the FHIR
API. Structure depends on `flatten` setting.
