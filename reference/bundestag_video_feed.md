# Get a Bundestag video feed entry

Get a Bundestag video feed entry

## Usage

``` r
bundestag_video_feed(content_id, safe = TRUE, refresh = FALSE)
```

## Arguments

- content_id:

  Video content id.

- safe:

  Logical; apply throttling and caching.

- refresh:

  Logical; refresh cached responses.

## Value

A tibble with video feed fields.

## Details

Returns a video feed entry from the Bundestag webtv service. Official
docs: https://bundesapi.github.io/bundestag-api/.

## Examples

``` r
if (FALSE) { # \dontrun{
bundestag_video_feed(7529016)
} # }
```
