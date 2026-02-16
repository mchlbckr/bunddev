# Locate the bunddev cache directory

Locate the bunddev cache directory

## Usage

``` r
bunddev_cache_dir()
```

## Value

Cache directory path.

## Details

The cache directory is used to store downloaded OpenAPI specs and cached
API responses. Use this to inspect or clean cached files.

## See also

[`bunddev_spec()`](https://buecker.ms/bunddev/reference/bunddev_spec.md)
to download specs, and
[`bunddev_spec_path()`](https://buecker.ms/bunddev/reference/bunddev_spec_path.md)
to locate a specific spec file.

## Examples

``` r
if (FALSE) { # \dontrun{
bunddev_cache_dir()
} # }
```
