# Get Bundesrat upcoming plenum sessions

Get Bundesrat upcoming plenum sessions

## Usage

``` r
bundesrat_plenum_naechste_sitzungen(
  view = "render[iOSDetailsWithoutInnerDate]",
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

A tibble with upcoming session metadata.

## Details

Returns upcoming Bundesrat sessions. Official docs:
https://bundesrat.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
bundesrat_plenum_naechste_sitzungen()
} # }
```
