# List current Bundesrat news

List current Bundesrat news

## Usage

``` r
bundesrat_aktuelles(view = "renderXml", safe = TRUE, refresh = FALSE)
```

## Arguments

- view:

  Rendering mode for the XML output.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with news items.

## Details

Returns current news items from the Bundesrat app feed. Official docs:
https://bundesrat.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
bundesrat_aktuelles()
} # }
```
