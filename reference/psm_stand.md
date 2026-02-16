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

A one-row tibble with version/release metadata. Top-level scalar API
fields are returned as tibble columns; nested objects or arrays are kept
in list-columns unless the function provides `flatten` / `flatten_mode`
controls.

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
