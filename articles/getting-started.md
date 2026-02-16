# Getting started

``` r
library(bunddev)
```

## Overview

`bunddev` provides a small registry of public APIs and helpers to
explore their OpenAPI specifications. Some APIs enforce rate limits;
check the registry details for service-specific guidance.

API-specific helpers return tidy tibbles by default. Use
[`bunddev_call()`](https://mchlbckr.github.io/bunddev/reference/bunddev_call.md)
for raw responses.

When `flatten = TRUE`, set `flatten_mode` to “json” (default), “drop”,
or “unnest”. Note that “unnest” expands list-columns into multiple rows.

Use `bunddev_parameters("<api>")` to see the currently valid parameters
for an API if the upstream spec has changed. For endpoint-specific
enums, use `bunddev_parameter_values(smard_timeseries, "resolution")`.

Several adapters add parsed POSIXct time columns (suffix `_time`) using
the Europe/Berlin timezone (for example `time` in SMARD, `start_time` in
DWD, and `date_time` in Tagesschau).

The package separates a core OpenAPI layer from adapter helpers for
specific APIs.

### Browse the registry

``` r
bunddev_list()
#> # A tibble: 41 × 8
#>    id                    title provider spec_url docs_url auth  rate_limit tags 
#>    <chr>                 <chr> <chr>    <chr>    <chr>    <chr> <chr>      <lis>
#>  1 abfallnavi            Abfa… regio iT https:/… https:/… none  NA         <chr>
#>  2 ausbildungssuche      Ausb… Bundesa… https:/… https:/… api_… NA         <chr>
#>  3 autobahn              Auto… Autobah… https:/… https:/… none  NA         <chr>
#>  4 bewerberboerse        Bewe… Bundesa… https:/… https:/… api_… NA         <chr>
#>  5 bundeshaushalt        Bund… Bundesm… https:/… https:/… none  NA         <chr>
#>  6 bundesrat             Bund… Bundesr… https:/… https:/… none  NA         <chr>
#>  7 bundestag             Bund… Deutsch… https:/… https:/… none  NA         <chr>
#>  8 bundestag_lobbyregis… Bund… Deutsch… https:/… https:/… none  NA         <chr>
#>  9 dashboard_deutschland Dash… Statist… https:/… https:/… none  NA         <chr>
#> 10 ddb                   Deut… Stiftun… https:/… https:/… none  NA         <chr>
#> # ℹ 31 more rows
```

### Acknowledgements

This package builds on the work of the bund.dev team, who curate and
centralize public sector APIs for the community (<https://bund.dev>,
<https://github.com/bundesAPI>).

Filter by tag to narrow down the list.

``` r
bunddev_list(tag = "jobs")
#> # A tibble: 3 × 8
#>   id               title       provider spec_url docs_url auth  rate_limit tags 
#>   <chr>            <chr>       <chr>    <chr>    <chr>    <chr> <chr>      <lis>
#> 1 ausbildungssuche Ausbildung… Bundesa… https:/… https:/… api_… NA         <chr>
#> 2 bewerberboerse   Bewerberbo… Bundesa… https:/… https:/… api_… NA         <chr>
#> 3 jobsuche         Jobsuche A… Bundesa… https:/… https:/… api_… NA         <chr>
```

### Inspect one API

``` r
bunddev_info("abfallnavi")
#> # A tibble: 1 × 8
#>   id         title          provider spec_url    docs_url auth  rate_limit tags 
#>   <chr>      <chr>          <chr>    <chr>       <chr>    <chr> <chr>      <lis>
#> 1 abfallnavi Abfallnavi API regio iT https://ra… https:/… none  NA         <chr>
```

### List endpoints

``` r
endpoints <- bunddev_endpoints("abfallnavi")
head(endpoints, 5)
#> # A tibble: 5 × 4
#>   method path                   operation_id          summary              
#>   <chr>  <chr>                  <chr>                 <chr>                
#> 1 get    /orte                  orte                  Orte im System       
#> 2 get    /orte/{ortId}          ort                   Informationen zu Ort 
#> 3 get    /orte/{ortId}/strassen strassenProOrt        Straßen im Ort       
#> 4 get    /strassen/{strassenId} hausnummernProStrasse Hausnummern in Straße
#> 5 get    /fraktionen            muellarten            Müllarten im System
```

### Bewerberboerse workflow

``` r
Sys.setenv(BEWERBERBOERSE_API_KEY = "jobboerse-bewerbersuche-ui")
bunddev_auth_set("bewerberboerse", type = "api_key", env_var = "BEWERBERBOERSE_API_KEY")

bewerber <- bewerberboerse_search(
  params = list(was = "data", size = 10),
  flatten = TRUE
)

details <- bewerberboerse_details(bewerber$refnr[[1]], flatten = TRUE)
```

### Autobahn workflow

``` r
roads <- autobahn_roads()
road_id <- roads$road_id[[1]]

roadworks <- autobahn_roadworks(road_id, flatten = TRUE)
warnings <- autobahn_warnings(road_id, flatten = TRUE)

roadwork_details <- autobahn_roadwork_details(roadworks$identifier[[1]], flatten = TRUE)
warning_details <- autobahn_warning_details(warnings$identifier[[1]], flatten = TRUE)
```

### Handelsregister workflow

``` r
companies <- handelsregister_search("deutsche bahn")
```

### SMARD workflow

``` r
library(ggplot2)

timestamp <- 1627250400000
series <- smard_timeseries(410, region = "DE", resolution = "hour", timestamp = timestamp)

ggplot(series, aes(time, value)) +
  geom_line() +
  labs(x = "Time", y = "MW")
```

`series$time` is a POSIXct column parsed in Europe/Berlin.

### DWD workflow

``` r
stations <- dwd_station_overview(c("10865", "G005"), flatten = TRUE)
```

### Jobsuche workflow

``` r
Sys.setenv(JOBBOERSE_API_KEY = "jobboerse-jobsuche")
bunddev_auth_set("jobsuche", type = "api_key", env_var = "JOBBOERSE_API_KEY")

jobs <- jobsuche_search(params = list(was = "data", size = 5), flatten = TRUE)
```

### Parameter discovery

``` r
bunddev_parameters("smard")
bunddev_parameter_values(smard_timeseries, "resolution")
```
