# Get a logo file

Get a logo file

## Usage

``` r
nina_logo(filename, safe = TRUE, refresh = FALSE)
```

## Arguments

- filename:

  Logo file name.

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A one-row tibble with `filename` and raw `bytes` in a list-column.

- content_id:

  Content identifier from NINA feeds (character), where applicable.

- response_country:

  Feed-level country code, when provided (character).

- response_last_modified:

  Feed-level modification timestamp in milliseconds (numeric).

- last_modified_time / effective_time:

  Parsed `POSIXct` timestamps in Europe/Berlin when source fields exist.

- Endpoint-specific fields:

  Additional scalar fields by endpoint; nested structures remain
  list-columns.

## See also

Other NINA:
[`nina_archive_mowas()`](https://buecker.ms/bunddev/reference/nina_archive_mowas.md),
[`nina_archive_mowas_mapping()`](https://buecker.ms/bunddev/reference/nina_archive_mowas_mapping.md),
[`nina_covid_infos()`](https://buecker.ms/bunddev/reference/nina_covid_infos.md),
[`nina_covid_map()`](https://buecker.ms/bunddev/reference/nina_covid_map.md),
[`nina_covid_rules()`](https://buecker.ms/bunddev/reference/nina_covid_rules.md),
[`nina_covid_ticker()`](https://buecker.ms/bunddev/reference/nina_covid_ticker.md),
[`nina_covid_ticker_message()`](https://buecker.ms/bunddev/reference/nina_covid_ticker_message.md),
[`nina_dashboard()`](https://buecker.ms/bunddev/reference/nina_dashboard.md),
[`nina_event_code()`](https://buecker.ms/bunddev/reference/nina_event_code.md),
[`nina_event_codes()`](https://buecker.ms/bunddev/reference/nina_event_codes.md),
[`nina_faqs()`](https://buecker.ms/bunddev/reference/nina_faqs.md),
[`nina_logos()`](https://buecker.ms/bunddev/reference/nina_logos.md),
[`nina_mapdata()`](https://buecker.ms/bunddev/reference/nina_mapdata.md),
[`nina_mowas_rss()`](https://buecker.ms/bunddev/reference/nina_mowas_rss.md),
[`nina_notfalltipps()`](https://buecker.ms/bunddev/reference/nina_notfalltipps.md),
[`nina_version()`](https://buecker.ms/bunddev/reference/nina_version.md),
[`nina_warning()`](https://buecker.ms/bunddev/reference/nina_warning.md),
[`nina_warning_geojson()`](https://buecker.ms/bunddev/reference/nina_warning_geojson.md),
[`nina_warning_json()`](https://buecker.ms/bunddev/reference/nina_warning_json.md),
[`nina_warnings()`](https://buecker.ms/bunddev/reference/nina_warnings.md)
