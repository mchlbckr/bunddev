# bunddev Roadmap

## Bucket list
- [ ] Add DWD historical data adapter for opendata.dwd.de (FTP/HTTP datasets)
- [ ] Expand SMARD helper coverage (table data metadata, resolution helpers)
- [ ] Add adapter-specific rate limit notes where sources are documented

## Adapters pending
- [x] abfallnavi
- [x] ausbildungssuche
- [x] autobahn
- [x] berufssprachkurssuche
- [x] bewerberboerse
- [x] bundeshaushalt
- [x] bundesrat
- [x] bundestag
- [x] bundestag_lobbyregister
- [x] coachingangebote
- [x] dashboard_deutschland
- [x] ddb
- [x] destatis
- [x] deutschlandatlas
- [x] dwd
- [x] diga
- [x] dip_bundestag
- [x] eco_visio
- [x] entgeltatlas
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
- [x] weiterbildungssuche (API returns 403 - may need browser auth)
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

### Blocked — Awaiting New Credentials

| API | Issue | Details |
|-----|-------|---------|
| **weiterbildungssuche** | HTTP 403 Forbidden | The Bundesagentur endpoint rejects requests. Both `weiterbildungssuche_search()` and `weiterbildungssuche_facetten()` fail. Awaiting new API keys. |

### Expired / Revoked OAuth2 Credentials

| API | Issue | Details |
|-----|-------|---------|
| **berufssprachkurssuche** | HTTP 401/403 | Public client ID `bd24f42e-ad0b-4005-b834-23bb6800dc6c` and secret `6776b89e-5728-4643-8cd5-c93aefb5314b` (from [GitHub docs](https://github.com/bundesAPI/berufssprachkurssuche-api)) no longer accepted. OAuth token endpoint also returns 403. |
| **coachingangebote** | HTTP 403 | Public client ID `ee971dcb-96fa-47b3-b2be-00863e4fc88b` and secret `1050e0b7-6db8-49e8-aff9-0e58e556681f` (from [GitHub docs](https://github.com/bundesAPI/coachingangebote-api)) no longer accepted. |
| **entgeltatlas** | HTTP 401/403 | Public client ID `c4f0d292-9d0f-4763-87dd-d3f9e78fb006` and secret `566c4dd6-942f-4cda-aad6-8d611c577107` (from [GitHub docs](https://github.com/bundesAPI/entgeltatlas-api)) no longer accepted. |

### Unreliable / Intermittent Failures

| API | Issue | Details |
|-----|-------|---------|
| **hochwasserzentralen** | `lagepegel` endpoint unstable | The `get_lagepegel.php` endpoint intermittently returns empty responses (HTTP 200 with no body). When it does return data, the schema may differ from the spec (`PGNR`, `LAT`, `LON` columns expected per OpenAPI spec). |

### Credentials Required (Not Yet Obtained)

| API | Auth Type | What's Needed | Provider |
|-----|-----------|---------------|----------|
| **diga** | Bearer Token | `DIGA_BEARER_TOKEN` | BfArM (applied, pending) |

### Upstream Spec Issues

| API | Issue | Details |
|-----|-------|---------|
| **entgeltatlas** | Malformed YAML spec | The upstream OpenAPI spec at `github.com/bundesAPI/entgeltatlas-api` has a YAML indentation error in the `info.description` block (line 16). `bunddev_spec()` now provides a clear error message when this occurs. The cached copy can be manually fixed by ensuring line 16 has 3 spaces of indentation. |

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
