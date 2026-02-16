# List registry entries

List registry entries

## Usage

``` r
bunddev_list(tag = NULL, auth = NULL)
```

## Arguments

- tag:

  Optional tag to filter on.

- auth:

  Optional auth type to filter on.

## Value

A tibble of registry entries.

## Details

Use this to quickly narrow down APIs by topic or authentication type.
Tags correspond to the taxonomy in the bundled registry.

## See also

[`bunddev_registry()`](https://buecker.ms/bunddev/reference/bunddev_registry.md)
for the full table and
[`bunddev_info()`](https://buecker.ms/bunddev/reference/bunddev_info.md)
for one entry.

## Examples

``` r
bunddev_list(tag = "jobs")
#> # A tibble: 3 × 8
#>   id               title       provider spec_url docs_url auth  rate_limit tags 
#>   <chr>            <chr>       <chr>    <chr>    <chr>    <chr> <chr>      <lis>
#> 1 ausbildungssuche Ausbildung… Bundesa… https:/… https:/… api_… NA         <chr>
#> 2 bewerberboerse   Bewerberbo… Bundesa… https:/… https:/… api_… NA         <chr>
#> 3 jobsuche         Jobsuche A… Bundesa… https:/… https:/… api_… NA         <chr>
bunddev_list(auth = "api_key")
#> # A tibble: 5 × 8
#>   id                  title    provider spec_url docs_url auth  rate_limit tags 
#>   <chr>               <chr>    <chr>    <chr>    <chr>    <chr> <chr>      <lis>
#> 1 ausbildungssuche    Ausbild… Bundesa… https:/… https:/… api_… NA         <chr>
#> 2 bewerberboerse      Bewerbe… Bundesa… https:/… https:/… api_… NA         <chr>
#> 3 dip_bundestag       DIP Bun… Deutsch… https:/… https:/… api_… NA         <chr>
#> 4 jobsuche            Jobsuch… Bundesa… https:/… https:/… api_… NA         <chr>
#> 5 lebensmittelwarnung Lebensm… Bundesa… https:/… https:/… api_… NA         <chr>
```
