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

The rate limit configuration.

## Details

If no explicit limit was set, the function tries to infer one from the
registry entry. The result is used by adapter helpers when
`safe = TRUE`.

## See also

[`bunddev_rate_limit_set()`](https://mchlbckr.github.io/bunddev/reference/bunddev_rate_limit_set.md)
to override the default.

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
