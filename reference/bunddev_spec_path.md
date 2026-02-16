# Build a cache path for an API spec

Build a cache path for an API spec

## Usage

``` r
bunddev_spec_path(id)
```

## Arguments

- id:

  Registry id.

## Value

File path for the cached spec.

## Details

Determines the cache file name based on the spec URL extension
(.yaml/.json).

## See also

[`bunddev_spec()`](https://mchlbckr.github.io/bunddev/reference/bunddev_spec.md)
to download and parse specs.

## Examples

``` r
if (FALSE) { # \dontrun{
bunddev_spec_path("smard")
} # }
```
