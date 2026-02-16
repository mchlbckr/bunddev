# List MaStR electricity generation data

List MaStR electricity generation data

## Usage

``` r
marktstammdaten_stromerzeugung(
  params = list(),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- params:

  Named list of query parameters:

  sort

  :   Sort definition string (character).

  page

  :   Page index (integer).

  pageSize

  :   Page size/number of returned entries (integer).

  filter

  :   Serialized filter expression from filter endpoints (character).

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
row per electricity generation unit and columns determined by the MaStR
API response. Common columns include `MaStRNummer`, `EinheitName`,
`Bundesland`, `Ort`, `Plz`, `Bruttoleistung`, `Nettonennleistung`,
`EnergietraegerName`, `BetriebsStatusName`, `InbetriebnahmeDatum`, and
`EinheitRegistrierungsdatum` (see
[`marktstammdaten_filters_stromerzeugung()`](https://buecker.ms/bunddev/reference/marktstammdaten_filters_stromerzeugung.md)
for available filter fields). Additionally:

- total:

  Numeric. Total number of matching records upstream.

- \*Datum_time:

  POSIXct. Parsed date column (Europe/Berlin) added for every source
  column whose name contains `Datum`.

## Details

Returns public electricity generation data from the MaStR. API
documentation: <https://github.com/bundesAPI/marktstammdaten-api>.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.

Other Marktstammdaten:
[`marktstammdaten_filters_gaserzeugung()`](https://buecker.ms/bunddev/reference/marktstammdaten_filters_gaserzeugung.md),
[`marktstammdaten_filters_gasverbrauch()`](https://buecker.ms/bunddev/reference/marktstammdaten_filters_gasverbrauch.md),
[`marktstammdaten_filters_stromerzeugung()`](https://buecker.ms/bunddev/reference/marktstammdaten_filters_stromerzeugung.md),
[`marktstammdaten_filters_stromverbrauch()`](https://buecker.ms/bunddev/reference/marktstammdaten_filters_stromverbrauch.md),
[`marktstammdaten_gaserzeugung()`](https://buecker.ms/bunddev/reference/marktstammdaten_gaserzeugung.md),
[`marktstammdaten_gasverbrauch()`](https://buecker.ms/bunddev/reference/marktstammdaten_gasverbrauch.md),
[`marktstammdaten_stromverbrauch()`](https://buecker.ms/bunddev/reference/marktstammdaten_stromverbrauch.md)

## Examples

``` r
if (FALSE) { # \dontrun{
marktstammdaten_stromerzeugung(params = list(page = 1, pageSize = 5))
} # }
```
