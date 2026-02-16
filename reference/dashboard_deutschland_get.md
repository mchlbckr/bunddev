# List Dashboard Deutschland entries

List Dashboard Deutschland entries

## Usage

``` r
dashboard_deutschland_get(
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

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

A tibble with dashboard entries.

## Details

Returns the full list of dashboard entries and metadata for each item.
Official docs: https://bundesapi.github.io/dashboard-deutschland-api/.

## Examples

``` r
if (FALSE) { # \dontrun{
dashboard_deutschland_get()
} # }
```
