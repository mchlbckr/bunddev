# Get a travel warning by content id

Get a travel warning by content id

## Usage

``` r
travelwarning_warning(content_id, safe = TRUE, refresh = FALSE)
```

## Arguments

- content_id:

  Travel warning content id.

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per warning content block. Same metadata columns
as
[`travelwarning_warnings()`](https://buecker.ms/bunddev/reference/travelwarning_warnings.md),
plus the full warning detail fields:

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

- iso3_country_code:

  Character. Three-letter ISO country code.

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

- content:

  Character. HTML content of the warning.

## Details

Returns the full travel warning content, including HTML blocks. API
documentation: <https://travelwarning.api.bund.dev>.

## See also

[`travelwarning_warnings()`](https://buecker.ms/bunddev/reference/travelwarning_warnings.md)
to list available ids.

Other Travelwarning:
[`travelwarning_healthcare()`](https://buecker.ms/bunddev/reference/travelwarning_healthcare.md),
[`travelwarning_representatives_country()`](https://buecker.ms/bunddev/reference/travelwarning_representatives_country.md),
[`travelwarning_representatives_germany()`](https://buecker.ms/bunddev/reference/travelwarning_representatives_germany.md),
[`travelwarning_state_names()`](https://buecker.ms/bunddev/reference/travelwarning_state_names.md),
[`travelwarning_warnings()`](https://buecker.ms/bunddev/reference/travelwarning_warnings.md)

## Examples

``` r
if (FALSE) { # \dontrun{
warnings <- travelwarning_warnings()
travelwarning_warning(warnings$content_id[[1]])
} # }
```
