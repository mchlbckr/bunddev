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

A named list with auth settings for `api`. If no configuration was set,
returns defaults with `type = "none"`.

## Details

Returns the stored auth configuration for the API or a default `none`
entry if no auth has been configured.

## See also

[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
to configure credentials.

Other Authentication:
[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)

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
