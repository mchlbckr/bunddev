# List approved plant protection products

List approved plant protection products

## Usage

``` r
psm_mittel(kennr = NULL, params = list(), safe = TRUE, refresh = FALSE)
```

## Arguments

- kennr:

  Optional product identification number (9 characters).

- params:

  Additional query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with plant protection product data.

## Details

The Pflanzenschutzmittelzulassung API provides access to Germany's plant
protection product database from the Bundesamt fuer Verbraucherschutz
und Lebensmittelsicherheit (BVL). This function returns approved
pesticides. Official docs:
https://github.com/bundesAPI/pflanzenschutzmittelzulassung-api.

## See also

[`psm_wirkstoffe()`](https://mchlbckr.github.io/bunddev/reference/psm_wirkstoffe.md)
to list active ingredients,
[`psm_stand()`](https://mchlbckr.github.io/bunddev/reference/psm_stand.md)
for data version.

## Examples

``` r
if (FALSE) { # \dontrun{
psm_mittel()
psm_mittel(kennr = "024780-00")
} # }
```
