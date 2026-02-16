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

## See also

Other OpenAPI:
[`bunddev_cache_dir()`](https://buecker.ms/bunddev/reference/bunddev_cache_dir.md),
[`bunddev_call()`](https://buecker.ms/bunddev/reference/bunddev_call.md),
[`bunddev_call_tidy()`](https://buecker.ms/bunddev/reference/bunddev_call_tidy.md),
[`bunddev_endpoints()`](https://buecker.ms/bunddev/reference/bunddev_endpoints.md),
[`bunddev_parameter_values()`](https://buecker.ms/bunddev/reference/bunddev_parameter_values.md),
[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md),
[`bunddev_parameters_for()`](https://buecker.ms/bunddev/reference/bunddev_parameters_for.md),
[`bunddev_spec()`](https://buecker.ms/bunddev/reference/bunddev_spec.md),
[`bunddev_spec_path()`](https://buecker.ms/bunddev/reference/bunddev_spec_path.md),
[`bunddev_timestamp_to_ms()`](https://buecker.ms/bunddev/reference/bunddev_timestamp_to_ms.md)

## Examples

``` r
bunddev_ms_to_posix(1704067200000, tz = "Europe/Berlin")
#> [1] "2024-01-01 01:00:00 CET"
```
