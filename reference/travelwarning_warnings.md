# List travel warnings

List travel warnings

## Usage

``` r
travelwarning_warnings(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per warning entry.

- content_id:

  Character. Entry/content identifier.

- parent_content_id:

  Character. Parent identifier for nested records.

- response_country:

  Character. Country code from response metadata.

- response_last_modified:

  Numeric. Feed-level modification timestamp in milliseconds.

- response_last_modified_time:

  POSIXct. Parsed feed-level timestamp (Europe/Berlin).

- last_modified_time:

  POSIXct. Entry-level modification timestamp (Europe/Berlin).

- effective_time:

  POSIXct. Entry effective timestamp (Europe/Berlin).

- last_modified:

  Numeric. Raw entry modification timestamp in ms.

- effective:

  Numeric. Raw entry effective timestamp in ms.

- title:

  Character. Country travel warning title.

- country_code:

  Character. Two-letter country code.

- country_name:

  Character. Country name (German).

- warning:

  Logical. Full travel warning issued.

- partial_warning:

  Logical. Partial travel warning issued.

- situation_warning:

  Logical. Situation-based travel warning.

- situation_part_warning:

  Logical. Situation-based partial warning.

## Details

The travelwarning API provides travel and safety information from the
Auswaertiges Amt. This endpoint returns a list of all travel warnings
with metadata. API documentation: <https://travelwarning.api.bund.dev>.

## See also

[`travelwarning_warning()`](https://buecker.ms/bunddev/reference/travelwarning_warning.md)
for full details of a single warning.

Other Travelwarning:
[`travelwarning_healthcare()`](https://buecker.ms/bunddev/reference/travelwarning_healthcare.md),
[`travelwarning_representatives_country()`](https://buecker.ms/bunddev/reference/travelwarning_representatives_country.md),
[`travelwarning_representatives_germany()`](https://buecker.ms/bunddev/reference/travelwarning_representatives_germany.md),
[`travelwarning_state_names()`](https://buecker.ms/bunddev/reference/travelwarning_state_names.md),
[`travelwarning_warning()`](https://buecker.ms/bunddev/reference/travelwarning_warning.md)

## Examples

``` r
if (FALSE) { # \dontrun{
travelwarning_warnings()
} # }
```
