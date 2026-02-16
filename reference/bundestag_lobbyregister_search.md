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

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with search metadata and result entries.

## Details

Returns search results from the Bundestag lobbyregister. Official docs:
https://bundesapi.github.io/bundestag-lobbyregister-api/.

## Examples

``` r
if (FALSE) { # \dontrun{
bundestag_lobbyregister_search(q = "energie")
} # }
```
