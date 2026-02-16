# Search the Bundestag lobbyregister

Search the Bundestag lobbyregister

## Usage

``` r
bundestag_lobbyregister_search(
  q = NULL,
  sort = NULL,
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- q:

  Optional search string.

- sort:

  Optional sorting order.

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

A one-row tibble with search metadata:

- source:

  Source label from the API payload (character).

- source_url:

  Source URL (character).

- search_url:

  URL of the executed search (character).

- search_date:

  Search timestamp/date string (character).

- search_parameters:

  Effective search parameter object (list-column).

- result_count:

  Total result count (integer).

- results:

  Search result entries (list-column).

## Details

Returns search results from the Bundestag lobbyregister. API
documentation:
<https://bundesapi.github.io/bundestag-lobbyregister-api/>.

## Examples

``` r
if (FALSE) { # \dontrun{
bundestag_lobbyregister_search(q = "energie")
} # }
```
