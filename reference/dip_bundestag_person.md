# Get a DIP Person

Get a DIP Person

## Usage

``` r
dip_bundestag_person(person_id, params = list(), safe = TRUE, refresh = FALSE)
```

## Arguments

- person_id:

  Person id.

- params:

  Query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with person metadata.

## Examples

``` r
if (FALSE) { # \dontrun{
dip_bundestag_person(1728)
} # }
```
