# List DIP Vorgangsposition entries

List DIP Vorgangsposition entries

## Usage

``` r
dip_bundestag_vorgangsposition_list(
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

A tibble with DIP response metadata.

## Details

Returns metadata for Vorgangsposition entries.

## Examples

``` r
if (FALSE) { # \dontrun{
dip_bundestag_vorgangsposition_list()
} # }
```
