# List Bundesrat plenum entries in chronological order

List Bundesrat plenum entries in chronological order

## Usage

``` r
bundesrat_plenum_chronologisch(
  view = "renderXml",
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- view:

  Rendering mode for the XML output.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with plenum entries.

## Details

Returns plenum entries ordered chronologically. Official docs:
https://bundesrat.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
bundesrat_plenum_chronologisch()
} # }
```
