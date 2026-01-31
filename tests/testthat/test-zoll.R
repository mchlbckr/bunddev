test_that("zoll_kurse returns a tibble", {
  # Skip: API behind Radware bot protection, returns 302/HTML
  skip("zoll API blocked by bot protection")
  skip_if_offline()
  skip_on_cran()

  results <- zoll_kurse()

  expect_s3_class(results, "tbl_df")
})

test_that("zoll_produktgruppen returns a tibble", {
  # Skip: API behind Radware bot protection, returns 302/HTML
  skip("zoll API blocked by bot protection")
  skip_if_offline()
  skip_on_cran()

  results <- zoll_produktgruppen()

  expect_s3_class(results, "tbl_df")
})
