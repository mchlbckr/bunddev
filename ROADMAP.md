# bunddev Roadmap

## Bucket list
- [ ] Add DWD historical data adapter for opendata.dwd.de (FTP/HTTP datasets)
- [ ] Expand SMARD helper coverage (table data metadata, resolution helpers)
- [ ] Add adapter-specific rate limit notes where sources are documented

## Adapters

### Active (33)

- [x] abfallnavi
- [x] ausbildungssuche
- [x] autobahn
- [x] bewerberboerse
- [x] bundeshaushalt
- [x] bundesrat
- [x] bundestag
- [x] bundestag_lobbyregister
- [x] dashboard_deutschland
- [x] ddb
- [x] destatis
- [x] deutschlandatlas
- [x] diga
- [x] dip_bundestag
- [x] dwd
- [x] eco_visio
- [x] feiertage
- [x] handelsregister
- [x] hilfsmittel
- [x] hochwasserzentralen
- [x] jobsuche
- [x] ladestationen
- [x] lebensmittelwarnung
- [x] luftqualitaet
- [x] marktstammdaten
- [x] mudab
- [x] nina
- [x] pegel_online
- [x] pflanzenschutzmittelzulassung
- [x] regionalatlas
- [x] smard
- [x] tagesschau
- [x] travelwarning

### Dormant (6)

Moved to `inst/dormant/` due to upstream issues. To revive, move the files
back to `R/` and `tests/testthat/`, re-add the registry entry, and run
`devtools::document()`.

| API | Issue |
|-----|-------|
| **interpol** | Akamai JS bot detection blocks non-browser clients |
| **zoll** | Endpoints removed (site redesigned) / Radware bot protection |
| **berufssprachkurssuche** | BA revoked public OAuth2 credentials |
| **coachingangebote** | BA revoked public OAuth2 credentials |
| **entgeltatlas** | BA confirmed no official public API, credentials revoked |
| **weiterbildungssuche** | Undocumented internal BA endpoint, credentials revoked |

### Not yet implemented

- [ ] fit_connect
- [ ] polizei_brandenburg
- [ ] rechtsinformationsportal
- [ ] rigoletto
- [ ] risikogebiete
- [ ] strahlenschutz
- [ ] studiensuche
- [ ] vag

## Known issues

| API | Issue |
|-----|-------|
| **hochwasserzentralen** | `lagepegel` endpoint intermittently returns empty responses |
| **diga** | Requires `DIGA_BEARER_TOKEN` (BfArM, applied, pending) |
