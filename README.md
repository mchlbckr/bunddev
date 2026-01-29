
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bunddev

<!-- badges: start -->

<!-- badges: end -->

The goal of bunddev is to provide a lightweight registry of public APIs
and helpers to explore their OpenAPI specs.

## Installation

You can install the development version of bunddev like so:

``` r
remotes::install_github("mchlbckr/bunddev")
```

## Example

This is a basic example showing how to browse the registry:

``` r
library(bunddev)

bunddev_list(tag = "jobs")
#> # A tibble: 5 × 7
#>   id               title                provider   spec_url docs_url auth  tags 
#>   <chr>            <chr>                <chr>      <chr>    <chr>    <chr> <lis>
#> 1 ausbildungssuche Ausbildungssuche API Bundesage… https:/… https:/… none  <chr>
#> 2 bewerberboerse   Bewerberboerse API   Bundesage… https:/… https:/… none  <chr>
#> 3 coachingangebote Coachingangebote API Bundesage… https:/… https:/… none  <chr>
#> 4 entgeltatlas     Entgeltatlas API     Bundesage… https:/… https:/… none  <chr>
#> 5 jobsuche         Jobsuche API         Bundesage… https:/… https:/… none  <chr>
bunddev_info("abfallnavi")
#> # A tibble: 1 × 7
#>   id         title          provider spec_url               docs_url auth  tags 
#>   <chr>      <chr>          <chr>    <chr>                  <chr>    <chr> <lis>
#> 1 abfallnavi Abfallnavi API regio iT https://raw.githubuse… https:/… none  <chr>
```
