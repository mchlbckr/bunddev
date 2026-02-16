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

  Query parameters.

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

A tibble with institution entries.

## Details

Returns institutions registered in the DDB. Requires the DDB API key.

## Examples

``` r
if (FALSE) { # \dontrun{
ddb_institutions(params = list(hasItems = TRUE))
} # }
```
