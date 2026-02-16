# Search training offers

Search training offers

## Usage

``` r
ausbildungssuche_search(
  params = list(),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- params:

  Named list of query parameters:

  sty

  :   Training type filter (integer).

  ids

  :   Occupation id(s), comma-separated (integer/character).

  orte

  :   Location id(s), comma-separated (integer/character).

  page

  :   Page index, starting at `0` (integer).

  size

  :   Page size (integer, max defined by API).

  uk

  :   Radius filter, e.g. `"25"` or `"Bundesweit"` (character).

  re

  :   Region/Bundesland code (character).

  bart

  :   Training category filter (integer).

  ityp

  :   Integration type filter (integer).

  bt

  :   Start date/time window filter (integer code).

  ban

  :   Provider id(s), comma-separated (integer/character).

  bg

  :   Only entries with Bildungsgutschein support (`TRUE`/`FALSE`).

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

- flatten:

  Logical; if `TRUE`, simplify nested list columns according to
  `flatten_mode`. Default `FALSE` keeps list columns as-is.

- flatten_mode:

  How to handle list columns when `flatten = TRUE`:

  `"drop"`

  :   Remove list columns entirely. Use when nested data is not needed.

  `"json"`

  :   Convert each list element to a JSON string. Preserves all data in
      a text-queryable format. This is the **default**.

  `"unnest"`

  :   Expand list columns into multiple rows via
      [`tidyr::unnest_longer()`](https://tidyr.tidyverse.org/reference/unnest_longer.html).
      **Warning:** this can significantly increase the number of rows.

## Value

A tibble with one row per training offer:

- id:

  Offer id (integer).

- unterrichtsform:

  Teaching format metadata (list-column).

- dauer:

  Duration metadata (list-column).

- anbieterbewertung:

  Provider rating text (character).

- angebot:

  Offer metadata (list-column).

- adresse:

  Address metadata (list-column).

- unterrichtszeiten:

  Class schedule text (character).

- kosten_wert:

  Cost value (character).

- kosten_waehrung:

  Cost currency (character).

- kosten_bemerkung:

  Cost note (character).

- foerderung:

  Funding flag (`TRUE`/`FALSE`).

- link:

  Offer link (character).

- bemerkung:

  Additional note text (character).

- beginn:

  Start date text (character).

- ende:

  End date text (character).

- individueller_einstieg:

  Flexible start flag (`TRUE`/`FALSE`).

- anmeldeschluss:

  Registration deadline text (character).

- bemerkung_zeit:

  Timing note (character).

- pruefende_stelle:

  Examining body (character).

- eigene_angebotsnummer:

  Provider's own offer id (character).

- teilnehmer_min:

  Minimum participants (integer).

- teilnehmer_max:

  Maximum participants (integer).

- aktualisierungsdatum:

  Update timestamp in milliseconds (numeric).

- aktualisierungsdatum_time:

  Update timestamp as `POSIXct` in Europe/Berlin.

- links:

  Top-level links object (list-column).

- aggregations:

  Aggregation metadata (list-column).

- page:

  Paging metadata (list-column).

## Details

The Ausbildungssuche API provides training offer data from the
Bundesagentur fuer Arbeit. Authentication is required via `X-API-Key`
(clientId `infosysbub-absuche`, discoverable from
https://web.arbeitsagentur.de/weiterbildungssuche/suche). API
documentation: <https://bundesapi.github.io/ausbildungssuche-api/>.

This adapter uses the `X-API-Key` header. Set it via
[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
and `AUSBILDUNGSSUCHE_API_KEY`.

## See also

[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.
[`ausbildungssuche_details()`](https://buecker.ms/bunddev/reference/ausbildungssuche_details.md)
for a single offer and
[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
for authentication.

Other Ausbildungssuche:
[`ausbildungssuche_details()`](https://buecker.ms/bunddev/reference/ausbildungssuche_details.md)

## Examples

``` r
if (FALSE) { # \dontrun{
Sys.setenv(AUSBILDUNGSSUCHE_API_KEY = "infosysbub-absuche")
bunddev_auth_set("ausbildungssuche", type = "api_key", env_var = "AUSBILDUNGSSUCHE_API_KEY")
ausbildungssuche_search(params = list(size = 5))
} # }
```
