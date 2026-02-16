# List active ingredients

List active ingredients

## Usage

``` r
psm_wirkstoffe(
  wirkstoffId = NULL,
  params = list(),
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- wirkstoffId:

  Optional active ingredient ID.

- params:

  Additional query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with active ingredient data.

## Details

Returns active ingredients (Wirkstoffe) from the plant protection
product database.

## See also

[`psm_mittel()`](https://buecker.ms/bunddev/reference/psm_mittel.md) to
list products.

## Examples

``` r
if (FALSE) { # \dontrun{
psm_wirkstoffe()
} # }
```
