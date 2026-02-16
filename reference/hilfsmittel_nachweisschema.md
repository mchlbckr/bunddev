# Get Hilfsmittel verification schema details

Get Hilfsmittel verification schema details

## Usage

``` r
hilfsmittel_nachweisschema(
  id,
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- id:

  Nachweisschema id.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with Nachweisschema details.

## Details

Returns detail information for a Nachweisschema. Official docs:
https://github.com/bundesAPI/hilfsmittel-api.

## Examples

``` r
if (FALSE) { # \dontrun{
hilfsmittel_nachweisschema("a3d37017-2c91-4d6d-bbbe-4002d2868044")
} # }
```
