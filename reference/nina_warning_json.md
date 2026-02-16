# Get a NINA warning (JSON)

Get a NINA warning (JSON)

## Usage

``` r
nina_warning_json(identifier, safe = TRUE, refresh = FALSE)
```

## Arguments

- identifier:

  Warning identifier.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with warning details.

Includes `sent_time` as POSIXct in Europe/Berlin.

## Details

Returns a warning in JSON format.

## See also

[`nina_mapdata()`](https://buecker.ms/bunddev/reference/nina_mapdata.md)
to discover identifiers.

## Examples

``` r
if (FALSE) { # \dontrun{
map <- nina_mapdata("mowas")
nina_warning_json(map$id[[1]])
} # }
```
