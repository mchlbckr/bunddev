<!-- README.md is generated from README.Rmd. Please edit that file -->

# bunddev <img src="man/figures/bunddev_hexagon.png" align="right" width="120" />

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/bunddev)](https://CRAN.R-project.org/package=bunddev)
[![CRAN
downloads](https://cranlogs.r-pkg.org/badges/grand-total/bunddev)](https://CRAN.R-project.org/package=bunddev)
[![R-CMD-check](https://github.com/mchlbckr/bunddev/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/mchlbckr/bunddev/actions/workflows/R-CMD-check.yaml)
[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub
release](https://img.shields.io/github/v/release/mchlbckr/bunddev)](https://github.com/mchlbckr/bunddev/releases)
[![GitHub
issues](https://img.shields.io/github/issues/mchlbckr/bunddev)](https://github.com/mchlbckr/bunddev/issues)
[![GitHub
stars](https://img.shields.io/github/stars/mchlbckr/bunddev?style=social)](https://github.com/mchlbckr/bunddev/stargazers)
<!-- badges: end -->

The goal of bunddev is to provide a lightweight registry of public APIs
and helpers to explore their OpenAPI specs. Some APIs enforce rate
limits; check the registry details for service-specific guidance.

API-specific helpers return tidy tibbles by default. Use
`bunddev_call()` for raw responses.

When `flatten = TRUE`, use `flatten_mode` to control list columns:
“json” keeps data as JSON strings (default), “drop” removes list
columns, and “unnest” expands list-columns into multiple rows.

Use `bunddev_parameters("<api>")` to see the currently valid parameters
for an API if the upstream spec has changed. For endpoint-specific
enums, use `bunddev_parameter_values(smard_timeseries, "resolution")`.

Several adapters add parsed POSIXct time columns (suffix `_time`) using
the Europe/Berlin timezone (for example `time` in SMARD, `start_time` in
DWD, and `date_time` in Tagesschau).

The package is organized into a core layer (registry, caching, OpenAPI
parsing) and adapter helpers for individual APIs.

Core files live in `R/core_*`, while adapters live in `R/adapt_*`. Add
new adapters by implementing tidy helpers that wrap
`bunddev_call_tidy()`.

## Installation

Install the released version from CRAN:

    install.packages("bunddev")

Or install the development version from GitHub:

    remotes::install_github("mchlbckr/bunddev")

## Acknowledgements

This package builds on the work of the bund.dev team, who curate and
centralize public sector APIs for the community (<https://bund.dev>,
<https://github.com/bundesAPI>).

## Examples

Browse the registry:

    library(bunddev)

    bunddev_list(tag = "jobs")
    #> # A tibble: 5 × 8
    #>   id               title       provider spec_url docs_url auth  rate_limit tags 
    #>   <chr>            <chr>       <chr>    <chr>    <chr>    <chr> <chr>      <lis>
    #> 1 ausbildungssuche Ausbildung… Bundesa… https:/… https:/… api_… <NA>       <chr>
    #> 2 bewerberboerse   Bewerberbo… Bundesa… https:/… https:/… api_… <NA>       <chr>
    #> 3 coachingangebote Coachingan… Bundesa… https:/… https:/… api_… <NA>       <chr>
    #> 4 entgeltatlas     Entgeltatl… Bundesa… https:/… https:/… none  <NA>       <chr>
    #> 5 jobsuche         Jobsuche A… Bundesa… https:/… https:/… api_… <NA>       <chr>
    bunddev_info("abfallnavi")
    #> # A tibble: 1 × 8
    #>   id         title          provider spec_url    docs_url auth  rate_limit tags 
    #>   <chr>      <chr>          <chr>    <chr>       <chr>    <chr> <chr>      <lis>
    #> 1 abfallnavi Abfallnavi API regio iT https://ra… https:/… none  <NA>       <chr>

Call the Bewerberboerse API (requires an API key header):

    library(bunddev)

    Sys.setenv(BEWERBERBOERSE_API_KEY = "jobboerse-bewerbersuche-ui")
    bunddev_auth_set("bewerberboerse", type = "api_key", env_var = "BEWERBERBOERSE_API_KEY")

    bewerber <- bewerberboerse_search(
      params = list(was = "data", size = 10),
      flatten = TRUE
    )

    details <- bewerberboerse_details(bewerber$refnr[[1]], flatten = TRUE)

Use the Autobahn API with list and detail helpers:

    library(bunddev)

    roads <- autobahn_roads()
    road_id <- roads$road_id[[1]]

    roadworks <- autobahn_roadworks(road_id, flatten = TRUE)
    warnings <- autobahn_warnings(road_id, flatten = TRUE)

    roadwork_details <- autobahn_roadwork_details(roadworks$identifier[[1]], flatten = TRUE)
    warning_details <- autobahn_warning_details(warnings$identifier[[1]], flatten = TRUE)

Handelsregister search (default rate limit is applied from the
registry):

    companies <- handelsregister_search("deutsche bahn")

SMARD time series example (historical timestamp):

    library(bunddev)
    library(ggplot2)

    timestamp <- 1627250400000
    series <- smard_timeseries(410, region = "DE", resolution = "hour", timestamp = timestamp)

    ggplot(series, aes(time, value)) +
      geom_line() +
      labs(x = "Time", y = "MW")

`series$time` is a POSIXct column parsed in Europe/Berlin.

DWD station overview example:

    library(bunddev)

    stations <- dwd_station_overview(c("10865", "G005"), flatten = TRUE)

Jobsuche example (requires API key header):

    library(bunddev)

    Sys.setenv(JOBBOERSE_API_KEY = "jobboerse-jobsuche")
    bunddev_auth_set("jobsuche", type = "api_key", env_var = "JOBBOERSE_API_KEY")

    jobs <- jobsuche_search(params = list(was = "data", size = 5), flatten = TRUE)

Inspect current parameters from the OpenAPI spec:

    bunddev_parameters("smard")
    bunddev_parameter_values(smard_timeseries, "resolution")
