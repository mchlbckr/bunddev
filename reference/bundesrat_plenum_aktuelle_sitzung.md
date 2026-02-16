# List Bundesrat current plenum session entries

List Bundesrat current plenum session entries

## Usage

``` r
bundesrat_plenum_aktuelle_sitzung(
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

A tibble with current plenum session entries.

## Details

Returns entries for the current plenum session. Official docs:
https://bundesrat.api.bund.dev.

## Examples

``` r
if (FALSE) { # \dontrun{
bundesrat_plenum_aktuelle_sitzung()
} # }
```
