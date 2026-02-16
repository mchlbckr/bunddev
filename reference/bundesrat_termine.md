# List Bundesrat dates and events

List Bundesrat dates and events

## Usage

``` r
bundesrat_termine(view = "renderXml", safe = TRUE, refresh = FALSE)
```

## Arguments

- view:

  Rendering mode for the XML output.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with dates and events.

## Details

Returns scheduled Bundesrat dates and events. Official docs:
https://bundesrat.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
bundesrat_termine()
} # }
```
