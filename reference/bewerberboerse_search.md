# Search the Bewerberboerse API

Search the Bewerberboerse API

## Usage

``` r
bewerberboerse_search(params = list(), flatten = FALSE, flatten_mode = "json")
```

## Arguments

- params:

  List of query parameters.

- flatten:

  Logical; drop nested list columns.

- flatten_mode:

  Flatten strategy for list columns. Use "unnest" to expand list-columns
  into multiple rows.

## Value

A tibble containing candidate listings with columns including reference
number, availability, location, skills, and contact flags. When
`flatten = FALSE`, includes nested list columns for education and
experience. Metadata columns include `page`, `size`, and
`max_ergebnisse`.

## Details

The Bewerberboerse API provides access to candidate listings.
Authentication uses an API key passed as `X-API-Key` (clientId
`jobboerse-bewerbersuche-ui`). See
https://bundesapi.github.io/bewerberboerse-api/ for official docs.

Use
[`bunddev_auth_set()`](https://mchlbckr.github.io/bunddev/reference/bunddev_auth_set.md)
to configure the key and
[`bunddev_parameters()`](https://mchlbckr.github.io/bunddev/reference/bunddev_parameters.md)
to inspect available query parameters.

## See also

[`bewerberboerse_details()`](https://mchlbckr.github.io/bunddev/reference/bewerberboerse_details.md)
for detailed entries and
[`bunddev_auth_set()`](https://mchlbckr.github.io/bunddev/reference/bunddev_auth_set.md)
for authentication setup.

## Examples

``` r
if (FALSE) { # \dontrun{
Sys.setenv(BEWERBERBOERSE_API_KEY = "jobboerse-bewerbersuche-ui")
bunddev_auth_set("bewerberboerse", type = "api_key", env_var = "BEWERBERBOERSE_API_KEY")
bewerberboerse_search(params = list(was = "data", size = 10), flatten = TRUE)
} # }
```
