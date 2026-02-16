# Retrieve Destatis table data

Retrieve Destatis table data

## Usage

``` r
destatis_data_table(
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

  Table id.

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

A tibble with table data in a text column.

## Details

Returns table data as text (csv by default). Official docs:
https://github.com/bundesAPI/destatis-api.

## Examples

``` r
if (FALSE) { # \dontrun{
destatis_data_table("12411-0001")
} # }
```
