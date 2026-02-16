# List Destatis tables

List Destatis tables

## Usage

``` r
destatis_catalogue_tables(
  params = list(),
  username = "GAST",
  password = "GAST",
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- params:

  Query parameters.

- username:

  Genesis username (default "GAST").

- password:

  Genesis password (default "GAST").

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with the raw response payload.

## Details

Returns the table catalogue from the Destatis Genesis API. Official
docs: https://github.com/bundesAPI/destatis-api.

## Examples

``` r
if (FALSE) { # \dontrun{
destatis_catalogue_tables()
} # }
```
