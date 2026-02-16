# Get Bundesrat voting distribution

Get Bundesrat voting distribution

## Usage

``` r
bundesrat_stimmverteilung(
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

A tibble with voting distribution metadata.

## Details

Returns the Bundesrat voting distribution. Official docs:
https://bundesrat.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
bundesrat_stimmverteilung()
} # }
```
