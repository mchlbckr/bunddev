# List available places

List available places

## Usage

``` r
abfallnavi_orte(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with places.

## Details

The Abfallnavi API provides waste collection data for supported regions.
Start by listing places (Orte) to obtain an `ortId`. Official docs:
https://bundesapi.github.io/abfallnavi-api/.

## See also

[`abfallnavi_strassen()`](https://mchlbckr.github.io/bunddev/reference/abfallnavi_strassen.md)
for streets in a place.

## Examples

``` r
if (FALSE) { # \dontrun{
abfallnavi_orte()
} # }
```
