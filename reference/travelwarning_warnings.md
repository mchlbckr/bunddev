# List travel warnings

List travel warnings

## Usage

``` r
travelwarning_warnings(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with travel warnings.

Includes `last_modified_time` and `effective_time` as POSIXct in
Europe/Berlin.

## Details

The travelwarning API provides travel and safety information from the
Auswaertiges Amt. This endpoint returns a list of all travel warnings
with metadata. Official docs: https://travelwarning.api.bund.dev.

## See also

[`travelwarning_warning()`](https://mchlbckr.github.io/bunddev/reference/travelwarning_warning.md)
for full details of a single warning.

## Examples

``` r
if (FALSE) { # \dontrun{
travelwarning_warnings()
} # }
```
