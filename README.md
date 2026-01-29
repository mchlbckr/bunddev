
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

## Examples

Browse the registry:

``` r
library(bunddev)

bunddev_list(tag = "jobs")
#> # A tibble: 5 × 7
#>   id               title                provider   spec_url docs_url auth  tags 
#>   <chr>            <chr>                <chr>      <chr>    <chr>    <chr> <lis>
#> 1 ausbildungssuche Ausbildungssuche API Bundesage… https:/… https:/… none  <chr>
#> 2 bewerberboerse   Bewerberboerse API   Bundesage… https:/… https:/… api_… <chr>
#> 3 coachingangebote Coachingangebote API Bundesage… https:/… https:/… none  <chr>
#> 4 entgeltatlas     Entgeltatlas API     Bundesage… https:/… https:/… none  <chr>
#> 5 jobsuche         Jobsuche API         Bundesage… https:/… https:/… none  <chr>
bunddev_info("abfallnavi")
#> # A tibble: 1 × 7
#>   id         title          provider spec_url               docs_url auth  tags 
#>   <chr>      <chr>          <chr>    <chr>                  <chr>    <chr> <lis>
#> 1 abfallnavi Abfallnavi API regio iT https://raw.githubuse… https:/… none  <chr>
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
