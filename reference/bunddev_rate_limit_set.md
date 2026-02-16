# Set API rate limit configuration

Set API rate limit configuration

## Usage

``` r
bunddev_rate_limit_set(api, max_per_hour)
```

## Arguments

- api:

  Registry id.

- max_per_hour:

  Maximum number of calls per hour.

## Value

A named list with:

- max_per_hour:

  Maximum allowed calls per hour (integer).

- timestamps:

  Numeric Unix timestamps of tracked requests.

## Details

Use this to override or enforce a per-hour rate limit for a given API.
The default is inferred from the registry entry when available.

## See also

[`bunddev_rate_limit_get()`](https://buecker.ms/bunddev/reference/bunddev_rate_limit_get.md)
to inspect the current setting.

Other Throttling:
[`bunddev_rate_limit_get()`](https://buecker.ms/bunddev/reference/bunddev_rate_limit_get.md)

## Examples

``` r
bunddev_rate_limit_set("smard", max_per_hour = 60)
#> $max_per_hour
#> [1] 60
#> 
#> $timestamps
#> numeric(0)
#> 
```
