# List Destatis cubes

List Destatis cubes

## Usage

``` r
destatis_catalogue_cubes(
  params = list(),
  username = "GAST",
  password = "GAST",
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

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

A one-row tibble with one list-column `response` containing the parsed
catalogue payload.

- response:

  Catalogue endpoints: full API payload as list-column.

- name:

  Data endpoints: requested table/cube name (character).

- data:

  Data endpoints: full payload as list-column.

## Details

Returns the cube catalogue from the Destatis Genesis API. API
documentation: <https://github.com/bundesAPI/destatis-api>.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.

Other Destatis:
[`destatis_catalogue_tables()`](https://buecker.ms/bunddev/reference/destatis_catalogue_tables.md),
[`destatis_data_cube()`](https://buecker.ms/bunddev/reference/destatis_data_cube.md),
[`destatis_data_table()`](https://buecker.ms/bunddev/reference/destatis_data_table.md)

## Examples

``` r
if (FALSE) { # \dontrun{
destatis_catalogue_cubes()
} # }
```
