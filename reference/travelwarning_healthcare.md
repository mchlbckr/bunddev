# List healthcare documents

List healthcare documents

## Usage

``` r
travelwarning_healthcare(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with healthcare entries.

Includes `last_modified_time` as POSIXct in Europe/Berlin.

## Details

Returns healthcare documents provided by the Auswaertiges Amt. Official
docs: https://travelwarning.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
travelwarning_healthcare()
} # }
```
