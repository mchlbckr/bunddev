# Get a travel warning by content id

Get a travel warning by content id

## Usage

``` r
travelwarning_warning(content_id, safe = TRUE, refresh = FALSE)
```

## Arguments

- content_id:

  Travel warning content id.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with travel warning details.

Includes `last_modified_time` and `effective_time` as POSIXct in
Europe/Berlin.

## Details

Returns the full travel warning content, including HTML blocks. Official
docs: https://travelwarning.api.bund.dev.

## See also

[`travelwarning_warnings()`](https://mchlbckr.github.io/bunddev/reference/travelwarning_warnings.md)
to list available ids.

## Examples

``` r
if (FALSE) { # \dontrun{
warnings <- travelwarning_warnings()
travelwarning_warning(warnings$content_id[[1]])
} # }
```
