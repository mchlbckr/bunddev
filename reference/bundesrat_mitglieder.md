# List Bundesrat members

List Bundesrat members

## Usage

``` r
bundesrat_mitglieder(view = "renderXml", safe = TRUE, refresh = FALSE)
```

## Arguments

- view:

  Rendering mode for the XML output.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with member entries.

## Details

Returns Bundesrat member entries from the mobile feed. Official docs:
https://bundesrat.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
bundesrat_mitglieder()
} # }
```
