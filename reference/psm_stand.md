# Get data version

Get data version

## Usage

``` r
psm_stand(safe = TRUE, refresh = FALSE)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A one-row tibble with version/release metadata.

- Item fields:

  One column per top-level field of each `items` element (`m_row$$`
  removed).

- Nested fields:

  Stored as list-columns.

- response:

  Fallback payload for non-item responses (list-column).

## Details

Returns the release date/version of the plant protection product
database.

## See also

Other Pflanzenschutzmittelzulassung:
[`psm_anwendungen()`](https://buecker.ms/bunddev/reference/psm_anwendungen.md),
[`psm_kultur_gruppen()`](https://buecker.ms/bunddev/reference/psm_kultur_gruppen.md),
[`psm_mittel()`](https://buecker.ms/bunddev/reference/psm_mittel.md),
[`psm_schadorg_gruppen()`](https://buecker.ms/bunddev/reference/psm_schadorg_gruppen.md),
[`psm_wirkstoffe()`](https://buecker.ms/bunddev/reference/psm_wirkstoffe.md)

## Examples

``` r
if (FALSE) { # \dontrun{
psm_stand()
} # }
```
