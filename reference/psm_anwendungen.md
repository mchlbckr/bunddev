# List approved applications

List approved applications

## Usage

``` r
psm_anwendungen(
  kennr = NULL,
  awg_id = NULL,
  params = list(),
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- kennr:

  Optional product identification number.

- awg_id:

  Optional application identifier (16 characters).

- params:

  Additional query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with application data.

## Details

Returns approved applications (Anwendungsgebiete) which define the
combinations of products, crops, and pests for which use is permitted.

## See also

[`psm_mittel()`](https://mchlbckr.github.io/bunddev/reference/psm_mittel.md)
to list products.

## Examples

``` r
if (FALSE) { # \dontrun{
psm_anwendungen(kennr = "024780-00")
} # }
```
