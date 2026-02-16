# Build Authorization header value

Build Authorization header value

## Usage

``` r
bunddev_auth_header(api, token = NULL)
```

## Arguments

- api:

  Registry id.

- token:

  Optional token to use instead of env_var lookup.

## Value

A character string for the Authorization header, or NULL if no auth.

## Details

Constructs the Authorization header value based on the configured
scheme. Supports template-style schemes containing `%s` for the
key/token.
