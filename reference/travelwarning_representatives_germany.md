# List foreign representatives in Germany

List foreign representatives in Germany

## Usage

``` r
travelwarning_representatives_germany(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with representatives.

Includes `last_modified_time` as POSIXct in Europe/Berlin.

## Details

Returns a list of foreign representatives in Germany. Official docs:
https://travelwarning.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
travelwarning_representatives_germany()
} # }
```
