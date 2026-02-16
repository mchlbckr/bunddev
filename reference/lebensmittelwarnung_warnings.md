# List food and product warnings

List food and product warnings

## Usage

``` r
lebensmittelwarnung_warnings(
  food = list(),
  products = list(),
  safe = TRUE,
  refresh = FALSE,
  flatten = FALSE,
  flatten_mode = "json"
)
```

## Arguments

- food:

  Optional request options for food warnings (rows, start, sort, fq).

- products:

  Optional request options for product warnings (rows, start, sort, fq).

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

A tibble with warning entries.

Includes `published_date_time` as POSIXct in Europe/Berlin.

## Details

The Lebensmittelwarnungen API returns German food and product safety
warnings. Requests are sent as JSON to the `warnings/merged` endpoint.
Official docs: https://lebensmittelwarnung.api.bund.dev and
https://github.com/bundesAPI/lebensmittelwarnung-api.

The API expects an `Authorization` header. By default the adapter uses
the public key documented in the OpenAPI spec. Override it with
[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
if needed.

## See also

[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
to configure the authorization header.

## Examples

``` r
if (FALSE) { # \dontrun{
lebensmittelwarnung_warnings(food = list(rows = 10), products = list(rows = 0))
} # }
```
