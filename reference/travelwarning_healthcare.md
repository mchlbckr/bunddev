# List healthcare documents

List healthcare documents

## Usage

``` r
travelwarning_healthcare(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with healthcare entries and the same metadata columns as
[`travelwarning_warnings()`](https://buecker.ms/bunddev/reference/travelwarning_warnings.md):
`content_id`, `parent_content_id`, `response_country`,
`response_last_modified`, `response_last_modified_time`,
`last_modified_time`, `effective_time`, plus snake_cased entry fields.

- content_id:

  Entry/content identifier (character).

- parent_content_id:

  Parent identifier (character).

- response_country:

  Country code from response metadata (character).

- response_last_modified:

  Feed-level modification timestamp (numeric).

- last_modified_time / effective_time:

  Parsed `POSIXct` (Europe/Berlin).

- `<entry_field>`:

  Additional snake_cased columns from each entry.

## Details

Returns healthcare documents provided by the Auswaertiges Amt. API
documentation: <https://travelwarning.api.bund.dev>.

## See also

Other Travelwarning:
[`travelwarning_representatives_country()`](https://buecker.ms/bunddev/reference/travelwarning_representatives_country.md),
[`travelwarning_representatives_germany()`](https://buecker.ms/bunddev/reference/travelwarning_representatives_germany.md),
[`travelwarning_state_names()`](https://buecker.ms/bunddev/reference/travelwarning_state_names.md),
[`travelwarning_warning()`](https://buecker.ms/bunddev/reference/travelwarning_warning.md),
[`travelwarning_warnings()`](https://buecker.ms/bunddev/reference/travelwarning_warnings.md)

## Examples

``` r
if (FALSE) { # \dontrun{
travelwarning_healthcare()
} # }
```
