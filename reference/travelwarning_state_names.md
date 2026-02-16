# List state names documents

List state names documents

## Usage

``` r
travelwarning_state_names(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with state name entries.

Includes `last_modified_time` as POSIXct in Europe/Berlin.

## Details

Returns documents with state name information. Official docs:
https://travelwarning.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
travelwarning_state_names()
} # }
```
