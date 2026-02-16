# List map data

List map data

## Usage

``` r
nina_mapdata(
  source = c("katwarn", "biwapp", "mowas", "dwd", "lhp", "police"),
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- source:

  Map data source.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with map data entries.

Includes `start_date_time` as POSIXct in Europe/Berlin.

## Details

Valid sources are: `katwarn`, `biwapp`, `mowas`, `dwd`, `lhp`, `police`.
