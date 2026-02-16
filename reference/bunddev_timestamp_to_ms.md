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

## See also

Other OpenAPI:
[`bunddev_cache_dir()`](https://buecker.ms/bunddev/reference/bunddev_cache_dir.md),
[`bunddev_call()`](https://buecker.ms/bunddev/reference/bunddev_call.md),
[`bunddev_call_tidy()`](https://buecker.ms/bunddev/reference/bunddev_call_tidy.md),
[`bunddev_endpoints()`](https://buecker.ms/bunddev/reference/bunddev_endpoints.md),
[`bunddev_ms_to_posix()`](https://buecker.ms/bunddev/reference/bunddev_ms_to_posix.md),
[`bunddev_parameter_values()`](https://buecker.ms/bunddev/reference/bunddev_parameter_values.md),
[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md),
[`bunddev_parameters_for()`](https://buecker.ms/bunddev/reference/bunddev_parameters_for.md),
[`bunddev_spec()`](https://buecker.ms/bunddev/reference/bunddev_spec.md),
[`bunddev_spec_path()`](https://buecker.ms/bunddev/reference/bunddev_spec_path.md)

## Examples

``` r
bunddev_timestamp_to_ms(as.POSIXct("2024-01-01 00:00:00", tz = "Europe/Berlin"))
#> [1] 1.704064e+12
```
