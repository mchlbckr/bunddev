
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bunddev <img src="man/figures/bunddev_hexagon.png" align="right" width="120" />

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html)
<!-- badges: end -->

The goal of bunddev is to provide a lightweight registry of public APIs
and helpers to explore their OpenAPI specs. Some APIs enforce rate
limits; check the registry details for service-specific guidance.

API-specific helpers return tidy tibbles by default. Use
`bunddev_call()` for raw responses.

## Installation

You can install the development version of bunddev like so:

``` r
remotes::install_github("mchlbckr/bunddev")
```

## Examples

Browse the registry:

``` r
library(bunddev)

bunddev_list(tag = "jobs")
#> # A tibble: 5 × 8
#>   id               title       provider spec_url docs_url auth  rate_limit tags 
#>   <chr>            <chr>       <chr>    <chr>    <chr>    <chr> <chr>      <lis>
#> 1 ausbildungssuche Ausbildung… Bundesa… https:/… https:/… none  <NA>       <chr>
#> 2 bewerberboerse   Bewerberbo… Bundesa… https:/… https:/… api_… <NA>       <chr>
#> 3 coachingangebote Coachingan… Bundesa… https:/… https:/… none  <NA>       <chr>
#> 4 entgeltatlas     Entgeltatl… Bundesa… https:/… https:/… none  <NA>       <chr>
#> 5 jobsuche         Jobsuche A… Bundesa… https:/… https:/… none  <NA>       <chr>
bunddev_info("abfallnavi")
#> # A tibble: 1 × 8
#>   id         title          provider spec_url    docs_url auth  rate_limit tags 
#>   <chr>      <chr>          <chr>    <chr>       <chr>    <chr> <chr>      <lis>
#> 1 abfallnavi Abfallnavi API regio iT https://ra… https:/… none  <NA>       <chr>
```

Call the Bewerberboerse API (requires an API key header):

``` r
library(bunddev)

Sys.setenv(BEWERBERBOERSE_API_KEY = "jobboerse-bewerbersuche-ui")
bunddev_auth_set("bewerberboerse", type = "api_key", env_var = "BEWERBERBOERSE_API_KEY")

bewerber <- bunddev_bewerberboerse_search(
  params = list(was = "data", size = 10),
  flatten = TRUE
)

details <- bunddev_bewerberboerse_details(bewerber$refnr[[1]], flatten = TRUE)
```

Use the Autobahn API with list and detail helpers:

``` r
library(bunddev)

roads <- bunddev_autobahn_roads()
road_id <- roads$road_id[[1]]

roadworks <- bunddev_autobahn_roadworks(road_id, flatten = TRUE)
warnings <- bunddev_autobahn_warnings(road_id, flatten = TRUE)

roadwork_details <- bunddev_autobahn_roadwork_details(roadworks$identifier[[1]], flatten = TRUE)
warning_details <- bunddev_autobahn_warning_details(warnings$identifier[[1]], flatten = TRUE)
```
