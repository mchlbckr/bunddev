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

A tibble with a single registry entry.

## Details

Use this to access the spec URL, documentation URL, and authentication
requirements for a single API.

## See also

[`bunddev_list()`](https://mchlbckr.github.io/bunddev/reference/bunddev_list.md)
for discovery and
[`bunddev_registry()`](https://mchlbckr.github.io/bunddev/reference/bunddev_registry.md)
for the full table.

## Examples

``` r
bunddev_info("smard")
#> # A tibble: 1 × 8
#>   id    title     provider          spec_url     docs_url auth  rate_limit tags 
#>   <chr> <chr>     <chr>             <chr>        <chr>    <chr> <chr>      <lis>
#> 1 smard SMARD API Bundesnetzagentur https://raw… https:/… none  Mehr als … <chr>
```
