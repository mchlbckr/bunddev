# Get a DIP Plenarprotokoll

Get a DIP Plenarprotokoll

## Usage

``` r
dip_bundestag_plenarprotokoll(
  plenarprotokoll_id,
  params = list(),
  safe = TRUE,
  refresh = FALSE
)
```

## Arguments

- plenarprotokoll_id:

  Plenarprotokoll id.

- params:

  Query parameters.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with Plenarprotokoll metadata.

## Examples

``` r
if (FALSE) { # \dontrun{
dip_bundestag_plenarprotokoll(908)
} # }
```
