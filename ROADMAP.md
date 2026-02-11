# bunddev Roadmap

## Bucket list
- [ ] Add DWD historical data adapter for opendata.dwd.de (FTP/HTTP datasets)
- [ ] Expand SMARD helper coverage (table data metadata, resolution helpers)
- [ ] Add adapter-specific rate limit notes where sources are documented

## Adapters pending
- [x] abfallnavi
- [x] ausbildungssuche
- [x] autobahn
- [x] berufssprachkurssuche (dormant — BA revoked public OAuth2 credentials, see `inst/dormant/`)
- [x] bewerberboerse
- [x] bundeshaushalt
- [x] bundesrat
- [x] bundestag
- [x] bundestag_lobbyregister
- [x] coachingangebote (dormant — BA revoked public OAuth2 credentials, see `inst/dormant/`)
- [x] dashboard_deutschland
- [x] ddb
- [x] destatis
- [x] deutschlandatlas
- [x] dwd
- [x] diga
- [x] dip_bundestag
- [x] eco_visio
- [x] entgeltatlas (dormant — BA confirmed no official public API, credentials revoked, see `inst/dormant/`)
- [x] feiertage
- [x] hilfsmittel
- [x] handelsregister
- [x] hochwasserzentralen
- [x] interpol (dormant — Akamai JS bot detection, see `inst/dormant/`)
- [x] jobsuche
- [x] ladestationen
- [x] lebensmittelwarnung
- [x] luftqualitaet
- [x] marktstammdaten
- [x] mudab
- [x] nina
- [x] pegel_online
- [x] smard
- [x] pflanzenschutzmittelzulassung
- [x] regionalatlas
- [ ] fit_connect
- [ ] polizei_brandenburg
- [ ] rechtsinformationsportal
- [ ] rigoletto
- [ ] risikogebiete
- [ ] strahlenschutz
- [ ] studiensuche
- [x] tagesschau
- [x] travelwarning
- [ ] vag
- [x] weiterbildungssuche (dormant — undocumented internal BA endpoint, credentials revoked, see `inst/dormant/`)
- [x] zoll (dormant — endpoints removed / Radware bot protection, see `inst/dormant/`)

## Known API Issues (Tested 2026-02-10)

### Dormant — Blocked by JavaScript-Based Bot Detection

These adapters have been moved to `inst/dormant/` and removed from the
active package. To revive, move the files back to `R/` and `tests/testthat/`,
re-add the registry entry, and run `devtools::document()`.

| API | Issue | Details |
|-----|-------|---------|
| **interpol** | Akamai Bot Manager | `ws-public.interpol.int` uses Akamai's JavaScript-based bot detection. Requests work in a browser (the JS challenge sets a cookie) but fail from curl/httr2/any non-browser client with HTTP 403. The Python package `de-interpol` has the [same unresolved issue](https://github.com/bundesAPI/interpol-api/issues/10). No header workaround exists — a JS-capable client (e.g. `chromote`) would be needed. |
| **zoll** | Endpoints removed / Radware bot protection | The Kurse endpoint on `zoll.de` returns 404 (site redesigned, endpoint removed). The BMF endpoints (`produkte`, `laender`, `produktgruppen`, `kategorien`) on `bundesfinanzministerium.de` are behind Radware JS bot protection (302 + JS challenge). The `zoll.api.proxy.bund.dev` proxy returns 503 because the upstream is gone. |
| **berufssprachkurssuche** | OAuth2 credentials revoked | Public client ID from [GitHub docs](https://github.com/bundesAPI/berufssprachkurssuche-api) no longer accepted. OAuth token endpoint returns 403. Bundesagentur fuer Arbeit has revoked public credentials for these undocumented internal endpoints. |
| **coachingangebote** | OAuth2 credentials revoked | Public client ID from [GitHub docs](https://github.com/bundesAPI/coachingangebote-api) no longer accepted. Same BA credential revocation. |
| **entgeltatlas** | No official public API | Bundesagentur fuer Arbeit confirmed there is no official public API for Entgeltatlas. Public OAuth2 credentials from [GitHub docs](https://github.com/bundesAPI/entgeltatlas-api) have been revoked. |
| **weiterbildungssuche** | HTTP 403 / credentials revoked | Undocumented internal BA endpoint. Both `weiterbildungssuche_search()` and `weiterbildungssuche_facetten()` return 403. |

### Unreliable / Intermittent Failures

| API | Issue | Details |
|-----|-------|---------|
| **hochwasserzentralen** | `lagepegel` endpoint unstable | The `get_lagepegel.php` endpoint intermittently returns empty responses (HTTP 200 with no body). When it does return data, the schema may differ from the spec (`PGNR`, `LAT`, `LON` columns expected per OpenAPI spec). |

### Credentials Required (Not Yet Obtained)

| API | Auth Type | What's Needed | Provider |
|-----|-----------|---------------|----------|
| **diga** | Bearer Token | `DIGA_BEARER_TOKEN` | BfArM (applied, pending) |

### Bugs Fixed (2026-02-10)

- **dip_bundestag cache collision**: All list endpoints (`vorgang`, `person`, `drucksache`, etc.) returned identical data because `path` was not included in the response cache key. Fixed in `core_cache.R` and `core_call.R`.
- **dip_bundestag detail endpoint crash**: `dip_bundestag_tidy_detail()` crashed on responses with mixed-length list fields (e.g. `wahlperiode` with 5 items vs scalar fields). Fixed by wrapping list/vector values as list-columns.
- **handelsregister "error page" false positive**: The error-message div is always present in the HTML template. Removed overly aggressive error check that triggered on every request.
- **handelsregister search returning 0 results**: JSF form submission was missing the `form:btnSuche` submit button field, so the server ignored the search request.

### Registry Corrections (Applied)

- **dip_bundestag**: Changed `auth` from `none` to `api_key`. The API requires an `ApiKey` header. A public key is available at https://dip.bundestag.de/ueber-dip/hilfe/api.
- **entgeltatlas**: Changed `auth` from `none` to `oauth2`. The API requires OAuth2 client credentials.
- **ausbildungssuche**: Public key `infosysbub-absuche` works. Test updated to use it by default.
- **zoll**: Base URL updated from `zoll.de` / `bundesfinanzministerium.de` to `zoll.api.proxy.bund.dev`.
