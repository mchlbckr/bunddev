## R CMD check results

0 errors | 0 warnings | 1 note

## Test environment

- local: macOS (aarch64-apple-darwin), R 4.5.3

## Notes

- Re-submission of the archived package.
- This update addresses the archival issue caused by persistent cache writes
  during checks. During `R CMD check`, `bunddev` now uses a temporary cache
  directory instead of writing to the user cache under `tools::R_user_dir()`.
- Network-dependent tests have been tightened so transient upstream failures
  now skip cleanly instead of failing checks. Tests that require API keys or
  external network access are skipped on CRAN.
- The package provides an interface to German government APIs listed on
  <https://bund.dev>. Some adapter functions require API keys which are
  documented in the respective function help pages.
- The remaining note is:
  `checking for future file timestamps ... NOTE unable to verify current time`
  This was produced by the local check environment and is unrelated to the
  package sources.
