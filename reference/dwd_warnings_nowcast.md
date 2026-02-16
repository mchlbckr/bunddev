# Fetch DWD nowcast warnings

Fetch DWD nowcast warnings

## Usage

``` r
dwd_warnings_nowcast(
  language = c("de", "en"),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- language:

  Language code ("de" or "en").

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

A tibble with nowcast warnings.

Includes `start_time` and `end_time` as POSIXct in Europe/Berlin.

## Details

Retrieves nowcast weather warnings from the DWD App API. Official docs:
https://dwd.api.bund.dev.

## See also

[`dwd_municipality_warnings()`](https://mchlbckr.github.io/bunddev/reference/dwd_municipality_warnings.md)
and
[`dwd_coast_warnings()`](https://mchlbckr.github.io/bunddev/reference/dwd_coast_warnings.md).

## Examples

``` r
if (FALSE) { # \dontrun{
dwd_warnings_nowcast(language = "de", flatten = TRUE)
} # }
```
