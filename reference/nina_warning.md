# Get a NINA travel warning by content id

Get a NINA travel warning by content id

## Usage

``` r
nina_warning(content_id, safe = TRUE, refresh = FALSE)
```

## Arguments

- content_id:

  Travel warning content id.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with warning details.

Includes `last_modified_time` and `effective_time` as POSIXct in
Europe/Berlin.

## Details

Returns full travel warning content, including HTML blocks.

## See also

[`nina_warnings()`](https://buecker.ms/bunddev/reference/nina_warnings.md)
for ids.

## Examples

``` r
if (FALSE) { # \dontrun{
warnings <- nina_warnings()
nina_warning(warnings$content_id[[1]])
} # }
```
