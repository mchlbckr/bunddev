# List DiGA prescription units

List DiGA prescription units

## Usage

``` r
diga_charge_item_definitions(
  params = list(),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- params:

  Named list of FHIR search parameters:

  `_count`

  :   Maximum bundle size per request (integer, default `1000`).

  `_profile`

  :   FHIR profile URL used to restrict resource type (character).

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

- flatten:

  Logical; if `TRUE`, simplify nested list columns according to
  `flatten_mode`. Default `FALSE` keeps list columns as-is.

- flatten_mode:

  How to handle list columns when `flatten = TRUE`:

  `"drop"`

  :   Remove list columns entirely. Use when nested data is not needed.

  `"json"`

  :   Convert each list element to a JSON string. Preserves all data in
      a text-queryable format. This is the **default**.

  `"unnest"`

  :   Expand list columns into multiple rows via
      [`tidyr::unnest_longer()`](https://tidyr.tidyverse.org/reference/unnest_longer.html).
      **Warning:** this can significantly increase the number of rows.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with one
row per charge item definition and columns:

- resourceType:

  Character. FHIR resource type, always `"ChargeItemDefinition"`.

- id:

  Character. FHIR resource identifier.

- url:

  Character. Canonical URL of the resource.

- status:

  Character. Publication status.

- description:

  Character. Description text.

- meta:

  List. Resource metadata (profile, timestamps).

- identifier:

  List. Business identifiers.

- code:

  List. Charge item code.

- instance:

  List. Referenced device definitions.

- applicability:

  List. Applicability conditions.

- propertyGroup:

  List. Pricing properties.

- extension:

  List. FHIR profile extensions.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.

Other DiGA:
[`diga_catalog_entries()`](https://buecker.ms/bunddev/reference/diga_catalog_entries.md),
[`diga_device_definitions()`](https://buecker.ms/bunddev/reference/diga_device_definitions.md),
[`diga_organizations()`](https://buecker.ms/bunddev/reference/diga_organizations.md),
[`diga_questionnaire_responses()`](https://buecker.ms/bunddev/reference/diga_questionnaire_responses.md),
[`diga_questionnaires()`](https://buecker.ms/bunddev/reference/diga_questionnaires.md)
