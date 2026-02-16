# List state names documents

List state names documents

## Usage

``` r
travelwarning_state_names(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per state-name document:

- content_id:

  Character. Entry/content identifier.

- parent_content_id:

  Character. Parent identifier for nested records.

- response_country:

  Character. Country code from response metadata.

- response_last_modified:

  Numeric. Feed-level modification timestamp.

- response_last_modified_time:

  POSIXct. Parsed feed-level timestamp.

- last_modified_time:

  POSIXct. Entry-level modification timestamp.

- effective_time:

  POSIXct. Entry effective timestamp.

- last_modified:

  Numeric. Raw entry modification timestamp in ms.

- name:

  Character. Document name.

- url:

  Character. Download URL.

## Details

Returns documents with state name information. API documentation:
<https://travelwarning.api.bund.dev>.

## See also

Other Travelwarning:
[`travelwarning_healthcare()`](https://buecker.ms/bunddev/reference/travelwarning_healthcare.md),
[`travelwarning_representatives_country()`](https://buecker.ms/bunddev/reference/travelwarning_representatives_country.md),
[`travelwarning_representatives_germany()`](https://buecker.ms/bunddev/reference/travelwarning_representatives_germany.md),
[`travelwarning_warning()`](https://buecker.ms/bunddev/reference/travelwarning_warning.md),
[`travelwarning_warnings()`](https://buecker.ms/bunddev/reference/travelwarning_warnings.md)

## Examples

``` r
if (FALSE) { # \dontrun{
travelwarning_state_names()
} # }
```
