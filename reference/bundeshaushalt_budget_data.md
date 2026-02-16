# Query Bundeshaushalt budget data

Query Bundeshaushalt budget data

## Usage

``` r
bundeshaushalt_budget_data(
  params = list(),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- params:

  Query parameters.

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

A tibble with budget data and nested detail lists.

Includes `timestamp_time` as POSIXct in Europe/Berlin.

## Details

The Bundeshaushalt API provides budget data for federal income and
expenses. Required query parameters are `year` and `account`. Official
docs: https://github.com/bundesAPI/bundeshaushalt-api.

## Examples

``` r
if (FALSE) { # \dontrun{
bundeshaushalt_budget_data(params = list(year = 2021, account = "expenses"))
} # }
```
