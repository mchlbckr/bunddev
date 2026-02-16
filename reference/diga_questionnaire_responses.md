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

A tibble with one row per questionnaire response resource (same
structure rules as
[`diga_device_definitions()`](https://buecker.ms/bunddev/reference/diga_device_definitions.md)).

- Resource fields:

  One column per top-level scalar field in each FHIR `entry$resource`.

- Nested resource fields:

  Stored as list-columns.

- bundle:

  Returned as list-column when the response has no `entry` records.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.

Other DiGA:
[`diga_catalog_entries()`](https://buecker.ms/bunddev/reference/diga_catalog_entries.md),
[`diga_charge_item_definitions()`](https://buecker.ms/bunddev/reference/diga_charge_item_definitions.md),
[`diga_device_definitions()`](https://buecker.ms/bunddev/reference/diga_device_definitions.md),
[`diga_organizations()`](https://buecker.ms/bunddev/reference/diga_organizations.md),
[`diga_questionnaires()`](https://buecker.ms/bunddev/reference/diga_questionnaires.md)
