# List NINA travel warnings

List NINA travel warnings

## Usage

``` r
nina_warnings(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with warning metadata.

Includes `last_modified_time` and `effective_time` as POSIXct in
Europe/Berlin.

## Details

The NINA API provides warnings and app data from the Bundesamt fuer
Bevoelkerungsschutz. This endpoint returns a list of travel warnings
with metadata. Official docs: https://nina.api.bund.dev.

## See also

[`nina_warning()`](https://buecker.ms/bunddev/reference/nina_warning.md)
for a single warning and
[`nina_mapdata()`](https://buecker.ms/bunddev/reference/nina_mapdata.md)
for map-based alerts.

## Examples

``` r
if (FALSE) { # \dontrun{
nina_warnings()
} # }
```
