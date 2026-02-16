# List waste fractions for a street

List waste fractions for a street

## Usage

``` r
abfallnavi_fraktionen_strassen(strassen_id, safe = TRUE, refresh = FALSE)
```

## Arguments

- strassen_id:

  Street id.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with waste fractions.
