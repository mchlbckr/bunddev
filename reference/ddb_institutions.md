# List DDB institutions

List DDB institutions

## Usage

``` r
ddb_institutions(
  params = list(),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- params:

  Named list of institution query parameters:

  hasItems

  :   Only institutions with items (`TRUE`/`FALSE`).

  sector

  :   Sector filter (character).

  offset

  :   Start index for pagination (integer).

  length

  :   Maximum number of returned items (integer).

  zoomlevel

  :   Optional map zoom level parameter (character).

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

A tibble with institution entries when the API returns a homogeneous
list; otherwise a one-row tibble with list-column `response`.

## Details

Returns institutions registered in the DDB. Requires the DDB API key.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.

Other DDB:
[`ddb_institution_sectors()`](https://buecker.ms/bunddev/reference/ddb_institution_sectors.md),
[`ddb_search()`](https://buecker.ms/bunddev/reference/ddb_search.md)

## Examples

``` r
if (FALSE) { # \dontrun{
ddb_institutions(params = list(hasItems = TRUE))
} # }
```
