# Search the Bewerberboerse API

Search the Bewerberboerse API

## Usage

``` r
bewerberboerse_search(params = list(), flatten = FALSE, flatten_mode = "json")
```

## Arguments

- params:

  Named list of query parameters:

  was

  :   Search terms (skills, professions, keywords) (character).

  ausbildungsart

  :   Training type code, e.g. `au`, `ba`, `fo` (character).

  wo

  :   Location query (place/PLZ/state/country) (character).

  umkreis

  :   Radius in km around `wo` (integer).

  angebotsart

  :   Offer type code, e.g. `ar`, `az` (character).

  arbeitszeit

  :   Work time code, e.g. `vz`, `tz` (character).

  berufserfahrung

  :   Experience level code, e.g. `be`, `bg` (character).

  vertragsart

  :   Contract type code, e.g. `be`, `ub` (character).

  behinderung

  :   Accessibility filter code (character).

  page

  :   Page index (integer).

  size

  :   Number of results per page (integer).

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

A tibble with one row per candidate profile:

- refnr:

  Candidate reference number (character).

- verfuegbarkeit_von:

  Availability date text (character).

- aktualisierungsdatum:

  Last update date text (character).

- veroeffentlichungsdatum:

  Publication date text (character).

- stellenart:

  Position type (character).

- arbeitszeit_modelle:

  Work-time models, collapsed string (character).

- berufe:

  Occupations, collapsed string (character).

- letzte_taetigkeit_jahr:

  Year of most recent activity (character).

- letzte_taetigkeit_bezeichnung:

  Label of most recent activity (character).

- letzte_taetigkeit_aktuell:

  Whether latest activity is current (`TRUE`/`FALSE`).

- hat_email:

  Email contact available (`TRUE`/`FALSE`).

- hat_telefon:

  Phone contact available (`TRUE`/`FALSE`).

- hat_adresse:

  Postal address available (`TRUE`/`FALSE`).

- ort:

  City/locality (character).

- plz:

  Postal code (character).

- umkreis:

  Radius text returned by API (character).

- region:

  Region/state (character).

- land:

  Country (character).

- mehrere_arbeitsorte:

  Multiple work locations flag (`TRUE`/`FALSE`).

- ausbildungen:

  Education entries (list-column).

- erfahrung:

  Experience entries (list-column).

- operation_id:

  Operation identifier used by the tidier (character).

- page:

  Returned page index (integer).

- size:

  Returned page size (integer).

- max_ergebnisse:

  Total matching result count (integer).

## Details

The Bewerberboerse API provides access to candidate listings.
Authentication uses an API key passed as `X-API-Key` (clientId
`jobboerse-bewerbersuche-ui`). See
https://bundesapi.github.io/bewerberboerse-api/ for official docs.

Use
[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
to configure the key and
[`bunddev_parameters()`](https://buecker.ms/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.

## See also

[`bewerberboerse_details()`](https://buecker.ms/bunddev/reference/bewerberboerse_details.md)
for detailed entries and
[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
for authentication setup.

Other Bewerberboerse:
[`bewerberboerse_details()`](https://buecker.ms/bunddev/reference/bewerberboerse_details.md)

## Examples

``` r
if (FALSE) { # \dontrun{
Sys.setenv(BEWERBERBOERSE_API_KEY = "jobboerse-bewerbersuche-ui")
bunddev_auth_set("bewerberboerse", type = "api_key", env_var = "BEWERBERBOERSE_API_KEY")
bewerberboerse_search(params = list(was = "data", size = 10), flatten = TRUE)
} # }
```
