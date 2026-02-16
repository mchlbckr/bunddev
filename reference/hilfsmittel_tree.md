# List Hilfsmittel tree nodes

List Hilfsmittel tree nodes

## Usage

``` r
hilfsmittel_tree(level, safe = TRUE, refresh = FALSE)
```

## Arguments

- level:

  Tree level to retrieve (1-4).

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with tree nodes.

## Details

Returns nodes from the Hilfsmittel product tree up to the selected
level. Official docs: https://github.com/bundesAPI/hilfsmittel-api.

## Examples

``` r
if (FALSE) { # \dontrun{
hilfsmittel_tree(level = 1)
} # }
```
