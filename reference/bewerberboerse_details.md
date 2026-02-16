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

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble containing detailed information for a single candidate,
including personal details, skills, work history, education, and contact
preferences. Structure is similar to
[`bewerberboerse_search()`](https://buecker.ms/bunddev/reference/bewerberboerse_search.md)
results.

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

## Examples

``` r
if (FALSE) { # \dontrun{
Sys.setenv(BEWERBERBOERSE_API_KEY = "jobboerse-bewerbersuche-ui")
bunddev_auth_set("bewerberboerse", type = "api_key", env_var = "BEWERBERBOERSE_API_KEY")
bewerberboerse_details("12345", flatten = TRUE)
} # }
```
