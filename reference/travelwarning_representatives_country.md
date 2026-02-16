# List German representatives in foreign countries

List German representatives in foreign countries

## Usage

``` r
travelwarning_representatives_country(safe = TRUE, refresh = FALSE)
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

Returns a list of German representatives in foreign countries. Official
docs: https://travelwarning.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
travelwarning_representatives_country()
} # }
```
