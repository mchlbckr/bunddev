## R CMD check results

0 errors | 0 warnings | 0 notes

## Test environment

- local: macOS (aarch64-apple-darwin), R 4.4.x

## Notes

- This is the first submission of this package.
- Tests that require API keys or network access are skipped on CRAN
  (guarded by `testthat::skip_on_cran()`).
- The package provides an interface to German government APIs listed on
  <https://bund.dev>. Some adapter functions require API keys which are
  documented in the respective function help pages.
