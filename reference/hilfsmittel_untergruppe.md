# Get Hilfsmittel subgroup details

Get Hilfsmittel subgroup details

## Usage

``` r
hilfsmittel_untergruppe(
  id,
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- id:

  Untergruppe id.

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

A tibble with subgroup details.

## Details

Returns details for a subgroup (Untergruppe). Official docs:
https://github.com/bundesAPI/hilfsmittel-api.

## Examples

``` r
if (FALSE) { # \dontrun{
hilfsmittel_untergruppe("c92d1976-d3cb-4b9f-bcdf-805272a9ea86")
} # }
```
