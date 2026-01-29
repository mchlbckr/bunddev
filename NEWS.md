# bunddev 0.0.0.9000

- Added shared timestamp helpers and parsed POSIXct time columns (Europe/Berlin) across SMARD, DWD, Autobahn, and Tagesschau adapters.
- SMARD helpers now accept POSIXct/Date timestamps and return parsed `time` columns for series and table outputs.
- DWD helpers add parsed forecast, report, and warning time columns; Tagesschau and Autobahn helpers add parsed date/time columns.
- Documented parameter discovery helpers and time columns in README/vignette and adapter helpfiles.

- Initial package scaffolding with registry and OpenAPI helpers.
