# Get API rate limit configuration

Get API rate limit configuration

## Usage

``` r
bunddev_rate_limit_get(api)
```

## Arguments

- api:

  Registry id.

## Value

A named list with:

- max_per_hour:

  Configured/inferred calls-per-hour limit (integer or `NA`).

- timestamps:

  Numeric Unix timestamps of tracked requests.

## Details

If no explicit limit was set, the function tries to infer one from the
registry entry. The result is used by adapter helpers when
`safe = TRUE`.

## See also

[`bunddev_rate_limit_set()`](https://buecker.ms/bunddev/reference/bunddev_rate_limit_set.md)
to override the default.

Other Throttling:
[`bunddev_rate_limit_set()`](https://buecker.ms/bunddev/reference/bunddev_rate_limit_set.md)

## Examples

``` r
bunddev_rate_limit_get("smard")
#> $max_per_hour
#> [1] 60
#> 
#> $timestamps
#> numeric(0)
#> 
```
