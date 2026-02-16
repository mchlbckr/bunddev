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

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with offer details.

## Details

Returns detailed information for a single offer.

## See also

[`ausbildungssuche_search()`](https://buecker.ms/bunddev/reference/ausbildungssuche_search.md)
to find offer ids.

## Examples

``` r
if (FALSE) { # \dontrun{
Sys.setenv(AUSBILDUNGSSUCHE_API_KEY = "infosysbub-absuche")
bunddev_auth_set("ausbildungssuche", type = "api_key", env_var = "AUSBILDUNGSSUCHE_API_KEY")
ausbildungssuche_details(12345)
} # }
```
