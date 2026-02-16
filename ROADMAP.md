# bunddev Roadmap

## Bucket list

Add DWD historical data adapter for opendata.dwd.de (FTP/HTTP datasets)

Expand SMARD helper coverage (table data metadata, resolution helpers)

Add adapter-specific rate limit notes where sources are documented

## Adapters

### Active (33)

abfallnavi

ausbildungssuche

autobahn

bewerberboerse

bundeshaushalt

bundesrat

bundestag

bundestag_lobbyregister

dashboard_deutschland

ddb

destatis

deutschlandatlas

diga

dip_bundestag

dwd

eco_visio

feiertage

handelsregister

hilfsmittel

hochwasserzentralen

jobsuche

ladestationen

lebensmittelwarnung

luftqualitaet

marktstammdaten

mudab

nina

pegel_online

pflanzenschutzmittelzulassung

regionalatlas

smard

tagesschau

travelwarning

### Dormant (6)

Moved to `inst/dormant/` due to upstream issues. To revive, move the
files back to `R/` and `tests/testthat/`, re-add the registry entry, and
run `devtools::document()`.

| API                       | Issue                                                        |
|---------------------------|--------------------------------------------------------------|
| **interpol**              | Akamai JS bot detection blocks non-browser clients           |
| **zoll**                  | Endpoints removed (site redesigned) / Radware bot protection |
| **berufssprachkurssuche** | BA revoked public OAuth2 credentials                         |
| **coachingangebote**      | BA revoked public OAuth2 credentials                         |
| **entgeltatlas**          | BA confirmed no official public API, credentials revoked     |
| **weiterbildungssuche**   | Undocumented internal BA endpoint, credentials revoked       |

### Not yet implemented

fit_connect

polizei_brandenburg

rechtsinformationsportal

rigoletto

risikogebiete

strahlenschutz

studiensuche

vag

## Known issues

| API                     | Issue                                                       |
|-------------------------|-------------------------------------------------------------|
| **hochwasserzentralen** | `lagepegel` endpoint intermittently returns empty responses |
| **diga**                | Requires `DIGA_BEARER_TOKEN` (BfArM, applied, pending)      |
