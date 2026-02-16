# Retrieve Bewerberboerse candidate details

Retrieve Bewerberboerse candidate details

## Usage

``` r
bewerberboerse_details(referenznummer, flatten = FALSE, flatten_mode = "json")
```

## Arguments

- referenznummer:

  Bewerber referenznummer.

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

A tibble with the same columns as
[`bewerberboerse_search()`](https://buecker.ms/bunddev/reference/bewerberboerse_search.md),
filtered to the requested `referenznummer`.

## Details

Fetches details for a single candidate. The `referenznummer` typically
comes from
[`bewerberboerse_search()`](https://buecker.ms/bunddev/reference/bewerberboerse_search.md).
See https://bundesapi.github.io/bewerberboerse-api/.

## See also

[`bewerberboerse_search()`](https://buecker.ms/bunddev/reference/bewerberboerse_search.md)
to find candidates and
[`bunddev_auth_set()`](https://buecker.ms/bunddev/reference/bunddev_auth_set.md)
for auth.

Other Bewerberboerse:
[`bewerberboerse_search()`](https://buecker.ms/bunddev/reference/bewerberboerse_search.md)

## Examples

``` r
if (FALSE) { # \dontrun{
Sys.setenv(BEWERBERBOERSE_API_KEY = "jobboerse-bewerbersuche-ui")
bunddev_auth_set("bewerberboerse", type = "api_key", env_var = "BEWERBERBOERSE_API_KEY")
bewerberboerse_details("12345", flatten = TRUE)
} # }
```
