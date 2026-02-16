# Get authentication configuration for an API

Get authentication configuration for an API

## Usage

``` r
bunddev_auth_get(api)
```

## Arguments

- api:

  Registry id.

## Value

A list with auth settings.

## Details

Returns the stored auth configuration for the API or a default `none`
entry if no auth has been configured.

## See also

[`bunddev_auth_set()`](https://mchlbckr.github.io/bunddev/reference/bunddev_auth_set.md)
to configure credentials.

## Examples

``` r
bunddev_auth_get("jobsuche")
#> $type
#> [1] "none"
#> 
#> $env_var
#> [1] NA
#> 
#> $scheme
#> [1] NA
#> 
```
