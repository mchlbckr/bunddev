# List German public holidays

List German public holidays

## Usage

``` r
feiertage_list(
  jahr = NULL,
  nur_land = NULL,
  nur_daten = NULL,
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- jahr:

  Year to query (defaults to current year on the API).

- nur_land:

  Optional Bundesland code to filter.

- nur_daten:

  Logical; return only date values (1) or include names (0).

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per holiday:

- region:

  Bundesland code (character, `NA` for nationwide results).

- holiday:

  Holiday name (character).

- date:

  Date in `YYYY-MM-DD` format (character).

- note:

  Optional holiday note from the API (character or `NA`).

- date_time:

  Date as `POSIXct` in Europe/Berlin.

## Details

The Feiertage API returns German public holidays from a Wikipedia-based
dataset. The endpoint supports filtering by year and Bundesland.
Official docs: https://github.com/bundesAPI/feiertage-api.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
for available query parameters.

## Examples

``` r
if (FALSE) { # \dontrun{
feiertage_list(jahr = 2024)
feiertage_list(jahr = 2024, nur_land = "BY")
} # }
```
