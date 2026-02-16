# Retrieve Destatis table data

Retrieve Destatis table data

## Usage

``` r
destatis_data_table(
  name,
  params = list(),
  username = "GAST",
  password = "GAST",
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- name:

  Table id.

- params:

  Named list of Genesis API query parameters. Common keys:

  username

  :   Genesis username (added automatically from `username` if missing).

  password

  :   Genesis password (added automatically from `password` if missing).

  name

  :   Table/cube name for data endpoints (also set by `name` argument).

  selection

  :   Selection filter expression (character).

  area

  :   Regional scope code (character).

  pagelength

  :   Maximum number of returned entries (integer).

  language

  :   Response language code (character).

  searchcriterion

  :   Catalogue search field (character).

  sortcriterion

  :   Catalogue sort field (character).

  type

  :   Resource type filter (character).

  startyear

  :   Start year filter (integer).

  endyear

  :   End year filter (integer).

- username:

  Genesis username (default "GAST").

- password:

  Genesis password (default "GAST").

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A one-row tibble with:

- name:

  Requested table id (character).

- data:

  Raw response body (typically CSV/text) (character).

## Details

Returns table data as text (csv by default). API documentation:
<https://github.com/bundesAPI/destatis-api>.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.

Other Destatis:
[`destatis_catalogue_cubes()`](https://buecker.ms/bunddev/reference/destatis_catalogue_cubes.md),
[`destatis_catalogue_tables()`](https://buecker.ms/bunddev/reference/destatis_catalogue_tables.md),
[`destatis_data_cube()`](https://buecker.ms/bunddev/reference/destatis_data_cube.md)

## Examples

``` r
if (FALSE) { # \dontrun{
destatis_data_table("12411-0001")
} # }
```
