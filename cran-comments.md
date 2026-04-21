## R CMD check results

0 errors | 0 warnings | 1 note

## Test environment

- local: macOS (aarch64-apple-darwin), R 4.5.3

## Notes

- Re-submission of the archived package.
- This update fixes the CRAN incoming pretest notes from the previous
  submission:
  - outdated documentation URLs that redirected with HTTP 301 have been
    replaced by direct `https://*.api.bund.dev/` URLs;
  - the DESCRIPTION text has been reworded to avoid the spell-check note on
    "tibbles".
- The previous 0.2.2 changes remain in place:
  - during `R CMD check`, `bunddev` now uses a temporary cache directory
    instead of writing to the user cache under `tools::R_user_dir()`;
  - network-dependent tests now skip cleanly when upstream services are
    unavailable, and tests requiring API keys or external network access are
    skipped on CRAN.
- The package provides an interface to German government APIs listed on
  <https://bund.dev>. Some adapter functions require API keys which are
  documented in the respective function help pages.
- The remaining note is:
  `checking for future file timestamps ... NOTE unable to verify current time`
  This was produced by the local check environment and is unrelated to the
  package sources.
