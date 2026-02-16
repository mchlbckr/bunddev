# List foreign representatives in Germany

List foreign representatives in Germany

## Usage

``` r
travelwarning_representatives_germany(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per foreign representative in Germany:

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

- title:

  Character. Representation title.

- leader:

  Character. Head of mission.

- locales:

  Character. Languages spoken.

- country:

  Character. Country.

- zip:

  Character. Postal code.

- city:

  Character. City.

- region:

  Character. Region.

- street:

  Character. Street.

- number:

  Character. House number.

- departments:

  Character. Department details.

- fax:

  Character. Fax number.

- telefone:

  Character. Phone number.

- mail:

  Character. Email address.

- misc:

  Character. Miscellaneous notes.

- url:

  Character. External link.

- postal:

  Character. Postal address.

- type:

  Character. Address type (e.g. Botschaft).

- remark:

  Character. Remark.

- open:

  Character. Opening hours.

## Details

Returns a list of foreign representatives in Germany. API documentation:
<https://travelwarning.api.bund.dev>.

## See also

Other Travelwarning:
[`travelwarning_healthcare()`](https://buecker.ms/bunddev/reference/travelwarning_healthcare.md),
[`travelwarning_representatives_country()`](https://buecker.ms/bunddev/reference/travelwarning_representatives_country.md),
[`travelwarning_state_names()`](https://buecker.ms/bunddev/reference/travelwarning_state_names.md),
[`travelwarning_warning()`](https://buecker.ms/bunddev/reference/travelwarning_warning.md),
[`travelwarning_warnings()`](https://buecker.ms/bunddev/reference/travelwarning_warnings.md)

## Examples

``` r
if (FALSE) { # \dontrun{
travelwarning_representatives_germany()
} # }
```
