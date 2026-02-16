# Read the bundled API registry

Read the bundled API registry

## Usage

``` r
bunddev_registry()
```

## Value

A tibble with registry entries.

## Details

The registry is bundled with the package and contains metadata such as
the API title, provider, documentation URL, OpenAPI spec URL,
authentication type, and any declared rate limits. The data originates
from bund.dev and the bundesAPI registry.

## See also

[`bunddev_list()`](https://mchlbckr.github.io/bunddev/reference/bunddev_list.md)
for filtered listings,
[`bunddev_search()`](https://mchlbckr.github.io/bunddev/reference/bunddev_search.md)
for keyword searches, and
[`bunddev_info()`](https://mchlbckr.github.io/bunddev/reference/bunddev_info.md)
for a single entry.

## Examples

``` r
registry <- bunddev_registry()
head(registry, 3)
#> # A tibble: 3 × 8
#>   id               title       provider spec_url docs_url auth  rate_limit tags 
#>   <chr>            <chr>       <chr>    <chr>    <chr>    <chr> <chr>      <lis>
#> 1 abfallnavi       Abfallnavi… regio iT https:/… https:/… none  NA         <chr>
#> 2 ausbildungssuche Ausbildung… Bundesa… https:/… https:/… api_… NA         <chr>
#> 3 autobahn         Autobahn A… Autobah… https:/… https:/… none  NA         <chr>
```
