# Get Eco-Visio counter measurement data

Get Eco-Visio counter measurement data

## Usage

``` r
eco_visio_data(
  id_organisme,
  id_pdc,
  interval,
  flow_ids,
  begin = NULL,
  end = NULL,
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- id_organisme:

  Organization ID.

- id_pdc:

  Counter ID.

- interval:

  Aggregation interval (1-6: 1=15min, 2=hours, 3=days, 4=weeks,
  5=months, 6=years).

- flow_ids:

  Practice IDs (semicolon-separated string or character vector).

- begin:

  Optional start date (Date or "YYYY-MM-DD" string).

- end:

  Optional end date (Date or "YYYY-MM-DD" string).

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A tibble with one row per measurement interval:

- date:

  Interval timestamp/date label from the API (character).

- count:

  Count value for the selected flow(s) (integer).

- date_time:

  `date` converted to `POSIXct` in Europe/Berlin.

## Details

Returns measurement data for a specific counter. The `flow_ids`
parameter specifies which traffic types to include (e.g., pedestrians,
cyclists). Use
[`eco_visio_counters()`](https://buecker.ms/bunddev/reference/eco_visio_counters.md)
to discover available counters and their flow IDs.

## See also

[`eco_visio_counters()`](https://buecker.ms/bunddev/reference/eco_visio_counters.md)
to list available counters.

Other Eco Visio:
[`eco_visio_counters()`](https://buecker.ms/bunddev/reference/eco_visio_counters.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Get daily data for a counter
eco_visio_data(
  id_organisme = 4586,
  id_pdc = 100125331,
  interval = 4,
  flow_ids = "101125331"
)
} # }
```
