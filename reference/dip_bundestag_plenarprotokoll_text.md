# Get a DIP Plenarprotokoll text

Get a DIP Plenarprotokoll text

## Usage

``` r
dip_bundestag_plenarprotokoll_text(
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

A tibble with Plenarprotokoll text metadata.

## Examples

``` r
if (FALSE) { # \dontrun{
dip_bundestag_plenarprotokoll_text(908)
} # }
```
