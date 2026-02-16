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

A tibble with one row per warning content block and the same column
structure as
[`travelwarning_warnings()`](https://buecker.ms/bunddev/reference/travelwarning_warnings.md).

- content_id:

  Entry/content identifier (character).

- parent_content_id:

  Parent identifier for nested entry records, if applicable (character).

- response_country:

  Country code from response metadata (character).

- response_last_modified:

  Feed-level modification timestamp in milliseconds (numeric).

- response_last_modified_time:

  Feed-level modification timestamp as `POSIXct` (Europe/Berlin), when
  `response_last_modified` is non-`NA`.

- last_modified_time:

  Entry-level modification timestamp as `POSIXct` (Europe/Berlin),
  parsed from the entry `lastModified` field.

- effective_time:

  Entry effective timestamp as `POSIXct` (Europe/Berlin), parsed from
  the entry `effective` field.

- `<entry_field>`:

  Additional columns (snake_case) from each entry payload. Scalar values
  become character/numeric columns; nested structures remain
  list-columns.

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
