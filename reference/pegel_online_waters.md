# List Pegel-Online waters

List Pegel-Online waters

## Usage

``` r
pegel_online_waters(
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

A tibble with water metadata.

## Details

Lists waters available in Pegel-Online. Official docs:
https://pegel-online.api.bund.dev.

## See also

[`pegel_online_stations()`](https://buecker.ms/bunddev/reference/pegel_online_stations.md)
for station metadata.

## Examples

``` r
if (FALSE) { # \dontrun{
pegel_online_waters(params = list(limit = 5))
} # }
```
