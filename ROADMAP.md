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
- [x] interpol
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
- [x] zoll (API behind Radware bot protection - blocked)

## Known API Issues (Tested 2026-02-09)

### Blocked by Bot Protection / 403 Forbidden

| API | Issue | Details |
|-----|-------|---------|
| **zoll** | Blocked by bot protection | `zoll.api.bund.dev` rejects automated requests. All endpoints (`zoll_kurse`, `zoll_produktgruppen`, etc.) return errors. |
| **weiterbildungssuche** | HTTP 403 Forbidden | The Bundesagentur endpoint rejects requests. Both `weiterbildungssuche_search()` and `weiterbildungssuche_facetten()` fail. |
| **interpol** | HTTP 403 Forbidden | `interpol.api.bund.dev` returns 403 for red/yellow/UN notice queries. May require updated authentication or user-agent headers. |

### Unreliable / Intermittent Failures

| API | Issue | Details |
|-----|-------|---------|
| **handelsregister** | Returns error page | `handelsregister_search()` intermittently returns an HTML error page instead of JSON. The upstream service at `handelsregister.de` appears unreliable for automated access. |
| **hochwasserzentralen** | `lagepegel` endpoint unstable | The `get_lagepegel.php` endpoint intermittently returns empty responses (HTTP 200 with no body). When it does return data, the schema may differ from the spec (`PGNR`, `LAT`, `LON` columns expected per OpenAPI spec). |

### Credentials Required (Not Yet Obtained)

| API | Auth Type | What's Needed | Provider |
|-----|-----------|---------------|----------|
| **ausbildungssuche** | API Key | `AUSBILDUNGSSUCHE_API_KEY` | Bundesagentur fuer Arbeit |
| **berufssprachkurssuche** | OAuth2 | `BERUFSSPRACHKURSSUCHE_CLIENT_SECRET` | Bundesagentur fuer Arbeit |
| **coachingangebote** | API Key | `COACHINGANGEBOTE_API_KEY` | Bundesagentur fuer Arbeit |
| **diga** | Bearer Token | `DIGA_BEARER_TOKEN` | BfArM (applied, pending) |
| **entgeltatlas** | OAuth2 | Valid client credentials (public ones from upstream spec are expired) | Bundesagentur fuer Arbeit |

### Upstream Spec Issues

| API | Issue | Details |
|-----|-------|---------|
| **entgeltatlas** | Malformed YAML spec | The upstream OpenAPI spec at `github.com/bundesAPI/entgeltatlas-api` has a YAML indentation error in the `info.description` block (line 16). `bunddev_spec()` now provides a clear error message when this occurs. The cached copy can be manually fixed by ensuring line 16 has 3 spaces of indentation. |

### Registry Corrections (Applied)

- **dip_bundestag**: Changed `auth` from `none` to `api_key`. The API requires an `ApiKey` header. A public key is available at https://dip.bundestag.de/ueber-dip/hilfe/api.
- **entgeltatlas**: Changed `auth` from `none` to `oauth2`. The API requires OAuth2 client credentials.
