# Fetch DWD coastal warnings

Fetch DWD coastal warnings

## Usage

``` r
dwd_coast_warnings(
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

A tibble with coastal warnings.

## Details

Retrieves coastal warnings from the DWD App API. Official docs:
https://dwd.api.bund.dev.

## See also

[`dwd_warnings_nowcast()`](https://mchlbckr.github.io/bunddev/reference/dwd_warnings_nowcast.md)
and
[`dwd_municipality_warnings()`](https://mchlbckr.github.io/bunddev/reference/dwd_municipality_warnings.md).

## Examples

``` r
if (FALSE) { # \dontrun{
dwd_coast_warnings(language = "de", flatten = TRUE)
} # }
```
