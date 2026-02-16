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

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with holiday names and dates.

Region-level results include a `region` column and a `note` column for
holiday-specific hints.

Includes `date_time` as POSIXct in Europe/Berlin.

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
