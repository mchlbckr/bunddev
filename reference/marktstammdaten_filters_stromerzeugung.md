# List MaStR filter options for electricity generation

List MaStR filter options for electricity generation

## Usage

``` r
marktstammdaten_filters_stromerzeugung(
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

- flatten:

  Logical; if `TRUE`, simplify nested list columns according to
  `flatten_mode`. Default `FALSE` keeps list columns as-is.

- flatten_mode:

  How to handle list columns when `flatten = TRUE`:

  `"drop"`

  :   Remove list columns entirely. Use when nested data is not needed.

  `"json"`

  :   Convert each list element to a JSON string. Preserves all data in
      a text-queryable format. This is the **default**.

  `"unnest"`

  :   Expand list columns into multiple rows via
      [`tidyr::unnest_longer()`](https://tidyr.tidyverse.org/reference/unnest_longer.html).
      **Warning:** this can significantly increase the number of rows.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with one
row per available filter and columns:

- FilterName:

  Character. Machine-readable filter field name.

- ListObject:

  List. Selectable options (named with `Name`/`Value`).

- Type:

  Character. Filter data type (`"text"`, `"number"`, `"multidropdown"`,
  `"date"`, or `"boolean"`).

## Details

Returns filter definitions for public electricity generation data. API
documentation: <https://github.com/bundesAPI/marktstammdaten-api>.

## See also

Other Marktstammdaten:
[`marktstammdaten_filters_gaserzeugung()`](https://buecker.ms/bunddev/reference/marktstammdaten_filters_gaserzeugung.md),
[`marktstammdaten_filters_gasverbrauch()`](https://buecker.ms/bunddev/reference/marktstammdaten_filters_gasverbrauch.md),
[`marktstammdaten_filters_stromverbrauch()`](https://buecker.ms/bunddev/reference/marktstammdaten_filters_stromverbrauch.md),
[`marktstammdaten_gaserzeugung()`](https://buecker.ms/bunddev/reference/marktstammdaten_gaserzeugung.md),
[`marktstammdaten_gasverbrauch()`](https://buecker.ms/bunddev/reference/marktstammdaten_gasverbrauch.md),
[`marktstammdaten_stromerzeugung()`](https://buecker.ms/bunddev/reference/marktstammdaten_stromerzeugung.md),
[`marktstammdaten_stromverbrauch()`](https://buecker.ms/bunddev/reference/marktstammdaten_stromverbrauch.md)

## Examples

``` r
if (FALSE) { # \dontrun{
marktstammdaten_filters_stromerzeugung()
} # }
```
