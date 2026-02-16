# List Bundesrat API endpoints

List Bundesrat API endpoints

## Usage

``` r
bundesrat_startlist(view = "renderXml", safe = TRUE, refresh = FALSE)
```

## Arguments

- view:

  Rendering mode for the XML output.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with endpoint metadata.

## Details

Returns the start list for the Bundesrat mobile API, including the URLs
for other available resources. Official docs:
https://bundesrat.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
bundesrat_startlist()
} # }
```
