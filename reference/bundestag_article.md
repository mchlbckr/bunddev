# Get a Bundestag news article

Get a Bundestag news article

## Usage

``` r
bundestag_article(article_id, safe = TRUE, refresh = FALSE)
```

## Arguments

- article_id:

  Article id.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with article fields.

## Details

Returns a single Bundestag news article in XML format. Official docs:
https://bundesapi.github.io/bundestag-api/.

## Examples

``` r
if (FALSE) { # \dontrun{
bundestag_article(849630)
} # }
```
