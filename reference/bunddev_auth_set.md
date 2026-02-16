# Set authentication configuration for an API

Set authentication configuration for an API

## Usage

``` r
bunddev_auth_set(
  api,
  type = "api_key",
  env_var,
  scheme = NULL,
  oauth_url = NULL,
  oauth_secret_env = NULL,
  oauth_default_id = NULL,
  oauth_token_header = "OAuthAccessToken",
  oauth_fallback_header = "X-API-Key"
)
```

## Arguments

- api:

  Registry id.

- type:

  Authentication type ("none", "api_key", or "oauth2").

- env_var:

  Environment variable containing credentials (for api_key) or client ID
  (for oauth2).

- scheme:

  Authentication scheme used in the Authorization header (e.g.,
  "Bearer", "ApiKey", "OAuth").

- oauth_url:

  OAuth2 token endpoint URL (for oauth2 type).

- oauth_secret_env:

  OAuth2 client secret environment variable (for oauth2 type).

- oauth_default_id:

  Default OAuth2 client ID if env_var is not set (for oauth2 type).

- oauth_token_header:

  Header name for OAuth token (default "OAuthAccessToken").

- oauth_fallback_header:

  Header name when no secret available (default "X-API-Key").

## Value

A named list with stored authentication settings:

- type:

  Authentication type (`"none"`, `"api_key"`, `"oauth2"`).

- env_var:

  Environment variable name for credential lookup.

- scheme:

  Header scheme/template used for auth header construction.

- oauth_url:

  OAuth token endpoint URL (oauth2 only).

- oauth_secret_env:

  Environment variable name for OAuth client secret.

- oauth_default_id:

  Fallback OAuth client ID when `env_var` is unset.

- oauth_token_header:

  Header name used for OAuth access tokens.

- oauth_fallback_header:

  Header name used for fallback API key mode.

## Details

Store auth configuration used by
[`bunddev_call()`](https://buecker.ms/bunddev/reference/bunddev_call.md)
and adapter helpers.

For API key auth: set `env_var` to the name of an environment variable
containing the key. The key is sent as `Authorization: {scheme} <key>`.

For OAuth2 client credentials: set `oauth_url` to the token endpoint,
`env_var` to the client ID env var, and `oauth_secret_env` to the client
secret env var. If the secret is available, fetches an OAuth token;
otherwise falls back to sending the client ID as an API key.

## See also

[`bunddev_auth_get()`](https://buecker.ms/bunddev/reference/bunddev_auth_get.md)
to inspect the stored configuration, and
[`bunddev_call()`](https://buecker.ms/bunddev/reference/bunddev_call.md)
to make authenticated requests.

Other Authentication:
[`bunddev_auth_get()`](https://buecker.ms/bunddev/reference/bunddev_auth_get.md)

## Examples

``` r
# API key authentication
Sys.setenv(JOBBOERSE_API_KEY = "jobboerse-jobsuche")
bunddev_auth_set("jobsuche", type = "api_key", env_var = "JOBBOERSE_API_KEY", scheme = "X-API-Key")
#> $type
#> [1] "api_key"
#> 
#> $env_var
#> [1] "JOBBOERSE_API_KEY"
#> 
#> $scheme
#> [1] "X-API-Key"
#> 
#> $oauth_url
#> NULL
#> 
#> $oauth_secret_env
#> NULL
#> 
#> $oauth_default_id
#> NULL
#> 
#> $oauth_token_header
#> [1] "OAuthAccessToken"
#> 
#> $oauth_fallback_header
#> [1] "X-API-Key"
#> 

# OAuth2 client credentials
bunddev_auth_set("berufssprachkurssuche",
  type = "oauth2",
  oauth_url = "https://rest.arbeitsagentur.de/oauth/gettoken_cc",
  env_var = "BERUFSSPRACHKURSSUCHE_API_KEY",
  oauth_secret_env = "BERUFSSPRACHKURSSUCHE_CLIENT_SECRET",
  oauth_default_id = "bd24f42e-ad0b-4005-b834-23bb6800dc6c")
#> $type
#> [1] "oauth2"
#> 
#> $env_var
#> [1] "BERUFSSPRACHKURSSUCHE_API_KEY"
#> 
#> $scheme
#> NULL
#> 
#> $oauth_url
#> [1] "https://rest.arbeitsagentur.de/oauth/gettoken_cc"
#> 
#> $oauth_secret_env
#> [1] "BERUFSSPRACHKURSSUCHE_CLIENT_SECRET"
#> 
#> $oauth_default_id
#> [1] "bd24f42e-ad0b-4005-b834-23bb6800dc6c"
#> 
#> $oauth_token_header
#> [1] "OAuthAccessToken"
#> 
#> $oauth_fallback_header
#> [1] "X-API-Key"
#> 
```
