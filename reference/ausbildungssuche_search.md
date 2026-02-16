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

  Query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble with training offers.

Includes `aktualisierungsdatum_time` as POSIXct in Europe/Berlin.

## Details

The Ausbildungssuche API provides training offer data from the
Bundesagentur fuer Arbeit. Authentication is required via `X-API-Key`
(clientId `infosysbub-absuche`, discoverable from
https://web.arbeitsagentur.de/weiterbildungssuche/suche). Official docs:
https://bundesapi.github.io/ausbildungssuche-api/.

This adapter uses the `X-API-Key` header. Set it via
[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
and `AUSBILDUNGSSUCHE_API_KEY`.

## See also

[`ausbildungssuche_details()`](https://buecker.ms/bunddev/reference/ausbildungssuche_details.md)
for a single offer and
[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
for authentication.

## Examples

``` r
if (FALSE) { # \dontrun{
Sys.setenv(AUSBILDUNGSSUCHE_API_KEY = "infosysbub-absuche")
bunddev_auth_set("ausbildungssuche", type = "api_key", env_var = "AUSBILDUNGSSUCHE_API_KEY")
ausbildungssuche_search(params = list(size = 5))
} # }
```
