# List MaStR gas generation data

List MaStR gas generation data

## Usage

``` r
marktstammdaten_gaserzeugung(
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

A tibble with MaStR entries.

## Details

Returns public gas generation data from the MaStR. Official docs:
https://github.com/bundesAPI/marktstammdaten-api.

## Examples

``` r
if (FALSE) { # \dontrun{
marktstammdaten_gaserzeugung(params = list(page = 1, pageSize = 5))
} # }
```
