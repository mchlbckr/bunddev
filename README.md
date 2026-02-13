
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

An R interface to German government and public sector APIs listed on
[bund.dev](https://bund.dev). **33 ready-to-use adapters** return tidy
tibbles for immediate use in dplyr/ggplot2 workflows.

## Three-layer architecture

| Layer | What it does | Entry point |
|----|----|----|
| **Registry** | Browse and search all APIs on bund.dev | `bunddev_list()`, `bunddev_info()` |
| **OpenAPI core** | Explore specs and call any endpoint | `bunddev_spec()`, `bunddev_call()` |
| **Adapters** | Ready-made functions returning tidy tibbles | e.g. `smard_timeseries()`, `autobahn_roadworks()` |

Adapters include built-in response caching and rate limiting.

## Installation

Install the released version from CRAN:

``` r
install.packages("bunddev")
```

Or install the development version from GitHub:

``` r
remotes::install_github("mchlbckr/bunddev")
```

## Quick start

``` r
library(bunddev)

# Energy market data
series <- smard_timeseries(410, region = "DE", resolution = "hour")

# Weather warnings
dwd_warnings()

# Current news
tagesschau_homepage()

# Company search
handelsregister_search("deutsche bahn")

# Water levels
pegel_online_stations()

# Parliamentary documents
dip_bundestag_drucksache_list()
```

## Available adapters (33)

**Government & Parliament** — bundestag, bundesrat,
bundestag_lobbyregister, dip_bundestag, bundeshaushalt

**Environment & Weather** — dwd, luftqualitaet, hochwasserzentralen,
pegel_online, mudab, smard

**Statistics & Data** — destatis, deutschlandatlas, regionalatlas,
dashboard_deutschland

**Jobs & Education** — jobsuche, ausbildungssuche, bewerberboerse

**Transport & Infrastructure** — autobahn, ladestationen, eco_visio

**Safety & Alerts** — nina, lebensmittelwarnung, travelwarning,
pflanzenschutzmittelzulassung

**Health** — diga, hilfsmittel

**Culture & Media** — tagesschau, ddb

**Business** — handelsregister, marktstammdaten

**Other** — abfallnavi, feiertage

## Examples

### Browse the registry

``` r
library(bunddev)

bunddev_list(tag = "energy")
bunddev_info("smard")
```

### SMARD energy data with ggplot2

``` r
library(bunddev)
library(ggplot2)

series <- smard_timeseries(410, region = "DE", resolution = "hour",
                           timestamp = 1627250400000)

ggplot(series, aes(time, value)) +
  geom_line() +
  labs(x = "Time", y = "MW", title = "Electricity generation")
```

`series$time` is a POSIXct column parsed in Europe/Berlin.

### Autobahn roadworks

``` r
library(bunddev)

roads <- autobahn_roads()
roadworks <- autobahn_roadworks(roads$road_id[[1]], flatten = TRUE)
```

### DIP Bundestag parliamentary data

``` r
library(bunddev)

# List recent documents
docs <- dip_bundestag_drucksache_list(params = list(
  f.datum.start = "2025-01-01",
  f.drucksachetyp = "Gesetzentwurf"
))

# Get details for a specific document
dip_bundestag_drucksache(284229)

# Full text (includes text column)
dip_bundestag_drucksache_text(284229)
```

### Jobsuche (requires API key)

``` r
library(bunddev)

Sys.setenv(JOBBOERSE_API_KEY = "jobboerse-jobsuche")
bunddev_auth_set("jobsuche", type = "api_key", env_var = "JOBBOERSE_API_KEY")

jobs <- jobsuche_search(params = list(was = "data", size = 5), flatten = TRUE)
```

### Discover parameters from OpenAPI specs

``` r
bunddev_parameters("smard")
bunddev_parameter_values(smard_timeseries, "resolution")
```

## Acknowledgements

This package builds on the work of the [bund.dev](https://bund.dev) team
and the [bundesAPI](https://github.com/bundesAPI) community, who curate
and document public sector APIs.
