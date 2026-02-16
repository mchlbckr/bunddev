# Search registry entries

Search registry entries

## Usage

``` r
bunddev_search(q)
```

## Arguments

- q:

  Search query.

## Value

A tibble of matching registry entries.

## Details

Searches across registry ids, titles, providers, and tags using a simple
substring match.

## See also

[`bunddev_list()`](https://mchlbckr.github.io/bunddev/reference/bunddev_list.md)
to filter by tag or auth, and
[`bunddev_info()`](https://mchlbckr.github.io/bunddev/reference/bunddev_info.md)
for details on a single API.

## Examples

``` r
bunddev_search("weather")
#> # A tibble: 1 × 8
#>   id    title       provider            spec_url docs_url auth  rate_limit tags 
#>   <chr> <chr>       <chr>               <chr>    <chr>    <chr> <chr>      <lis>
#> 1 dwd   DWD App API Deutscher Wetterdi… https:/… https:/… none  NA         <chr>
```
