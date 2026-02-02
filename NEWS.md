# bunddev 0.1.0

## Initial Release

First public release of bunddev - a comprehensive R interface to German government and public sector APIs available through bund.dev.

### Package Structure

- **Registry System**: Centralized API registry with automatic endpoint discovery
- **Core OpenAPI Client**: Generic client layer for exploring specs and making requests
- **39 API Adapters**: Ready-to-use functions returning tidy tibbles for:
  - Government data (Bundestag, Bundesrat, Bundeshaushalt)
  - Environmental data (DWD weather, Luftqualität, SMARD energy, Pegel water levels)
  - Public services (Jobsuche, Weiterbildungssuche, Ausbildungssuche)
  - Transportation (Autobahn, Ladestationen)
  - Cultural data (Deutsche Digitale Bibliothek, Tagesschau)
  - And many more (see full list in README)

### Key Features

- **Authentication Support**: Flexible authentication system supporting API keys, OAuth2, and custom schemes
- **Response Caching**: Built-in caching to reduce API load and improve performance
- **Rate Limiting**: Configurable rate limiting to respect API quotas
- **Tidy Output**: All adapters return tibbles with consistent structure
- **Time Handling**: Automatic parsing of timestamps to POSIXct (Europe/Berlin timezone)
- **Parameter Discovery**: Helper functions to explore available parameters for each API
- **Comprehensive Documentation**: Vignettes, function documentation, and examples included

### Bug Fixes

- Fixed R CMD check errors and warnings
- Fixed DDB authentication to use correct OAuth format
- Exported time conversion utilities (`bunddev_ms_to_posix()`, `bunddev_timestamp_to_ms()`)
- Corrected package build configuration

# bunddev 0.0.0.9000 (Development)

- Added shared timestamp helpers and parsed POSIXct time columns (Europe/Berlin) across SMARD, DWD, Autobahn, and Tagesschau adapters.
- SMARD helpers now accept POSIXct/Date timestamps and return parsed `time` columns for series and table outputs.
- DWD helpers add parsed forecast, report, and warning time columns; Tagesschau and Autobahn helpers add parsed date/time columns.
- Documented parameter discovery helpers and time columns in README/vignette and adapter helpfiles.
- Initial package scaffolding with registry and OpenAPI helpers.
