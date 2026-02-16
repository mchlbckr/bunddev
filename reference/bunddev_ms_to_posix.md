# Convert milliseconds to POSIXct

Convert milliseconds to POSIXct

## Usage

``` r
bunddev_ms_to_posix(value, tz = "Europe/Berlin")
```

## Arguments

- value:

  Timestamp in milliseconds.

- tz:

  Timezone for conversion.

## Value

POSIXct timestamp.

## Details

Converts epoch milliseconds to POSIXct in the requested timezone.

## Examples

``` r
bunddev_ms_to_posix(1704067200000, tz = "Europe/Berlin")
#> [1] "2024-01-01 01:00:00 CET"
```
