# Convert timestamps to milliseconds

Convert timestamps to milliseconds

## Usage

``` r
bunddev_timestamp_to_ms(value, tz = "Europe/Berlin")
```

## Arguments

- value:

  Timestamp as numeric (ms), Date, or POSIXct.

- tz:

  Timezone for Date/POSIXct conversion.

## Value

Numeric timestamp in milliseconds.

## Details

This helper standardizes timestamps for APIs that expect epoch
milliseconds. Dates are interpreted in the supplied timezone.

## Examples

``` r
bunddev_timestamp_to_ms(as.POSIXct("2024-01-01 00:00:00", tz = "Europe/Berlin"))
#> [1] 1.704064e+12
```
