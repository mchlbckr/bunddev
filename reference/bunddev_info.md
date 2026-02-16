# Get a registry entry by id

Get a registry entry by id

## Usage

``` r
bunddev_info(id)
```

## Arguments

- id:

  Registry id.

## Value

A one-row tibble with the same columns as
[`bunddev_registry()`](https://buecker.ms/bunddev/reference/bunddev_registry.md).

## Details

Use this to access the spec URL, documentation URL, and authentication
requirements for a single API.

## See also

[`bunddev_list()`](https://buecker.ms/bunddev/reference/bunddev_list.md)
for discovery and
[`bunddev_registry()`](https://buecker.ms/bunddev/reference/bunddev_registry.md)
for the full table.

Other Registry:
[`bunddev_list()`](https://buecker.ms/bunddev/reference/bunddev_list.md),
[`bunddev_registry()`](https://buecker.ms/bunddev/reference/bunddev_registry.md),
[`bunddev_search()`](https://buecker.ms/bunddev/reference/bunddev_search.md)

## Examples

``` r
bunddev_info("smard")
#> # A tibble: 1 × 8
#>   id    title     provider          spec_url     docs_url auth  rate_limit tags 
#>   <chr> <chr>     <chr>             <chr>        <chr>    <chr> <chr>      <lis>
#> 1 smard SMARD API Bundesnetzagentur https://raw… https:/… none  Mehr als … <chr>
```
