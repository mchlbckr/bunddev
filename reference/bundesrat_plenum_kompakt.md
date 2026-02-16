# List Bundesrat plenum compact entries

List Bundesrat plenum compact entries

## Usage

``` r
bundesrat_plenum_kompakt(view = "renderXml", safe = TRUE, refresh = FALSE)
```

## Arguments

- view:

  Rendering mode for the XML output.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with plenum compact entries.

## Details

Returns plenum compact entries for Bundesrat sessions. Official docs:
https://bundesrat.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
bundesrat_plenum_kompakt()
} # }
```
