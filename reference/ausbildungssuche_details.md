# Get training offer details

Get training offer details

## Usage

``` r
ausbildungssuche_details(offer_id, safe = TRUE, refresh = FALSE)
```

## Arguments

- offer_id:

  Offer id.

- safe:

  Logical; if `TRUE` (default), apply rate-limiting and cache GET
  responses to `tools::R_user_dir("bunddev", "cache")`.

- refresh:

  Logical; if `TRUE`, ignore cached responses and re-fetch from the API
  (default `FALSE`).

## Value

A one-row tibble with:

- offer_id:

  Requested offer id.

- data:

  Raw detail payload for the offer (list-column).

## Details

Returns detailed information for a single offer.

## See also

[`ausbildungssuche_search()`](https://buecker.ms/bunddev/reference/ausbildungssuche_search.md)
to find offer ids.

Other Ausbildungssuche:
[`ausbildungssuche_search()`](https://buecker.ms/bunddev/reference/ausbildungssuche_search.md)

## Examples

``` r
if (FALSE) { # \dontrun{
Sys.setenv(AUSBILDUNGSSUCHE_API_KEY = "infosysbub-absuche")
bunddev_auth_set("ausbildungssuche", type = "api_key", env_var = "AUSBILDUNGSSUCHE_API_KEY")
ausbildungssuche_details(12345)
} # }
```
