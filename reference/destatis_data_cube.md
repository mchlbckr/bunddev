# Retrieve Destatis cube data

Retrieve Destatis cube data

## Usage

``` r
destatis_data_cube(
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

  Cube id.

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

A tibble with cube data in a text column.

## Details

Returns cube data as text (csv by default). Official docs:
https://github.com/bundesAPI/destatis-api.

## Examples

``` r
if (FALSE) { # \dontrun{
destatis_data_cube("21231BJ001")
} # }
```
