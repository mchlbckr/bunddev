# Fetch OAuth2 token for an API

Fetch OAuth2 token for an API

## Usage

``` r
bunddev_oauth_token(api)
```

## Arguments

- api:

  Registry id.

## Value

OAuth token string, or NULL if unavailable.

## Details

Fetches an OAuth2 access token using the client credentials flow.
Returns NULL if no client secret is available (will fall back to API key
auth).
