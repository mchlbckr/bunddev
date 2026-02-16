# List Bundesrat presidium entries

List Bundesrat presidium entries

## Usage

``` r
bundesrat_praesidium(view = "renderXml", safe = TRUE, refresh = FALSE)
```

## Arguments

- view:

  Rendering mode for the XML output.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with presidium entries.

## Details

Returns Bundesrat presidium entries. Official docs:
https://bundesrat.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
bundesrat_praesidium()
} # }
```
