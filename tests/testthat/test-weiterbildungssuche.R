test_that("weiterbildungssuche_search returns a tibble", {
  # Skip: API returns 403 Forbidden - may require browser-based auth
  skip("weiterbildungssuche API returns 403")
  skip_if_offline()
  skip_on_cran()

  results <- weiterbildungssuche_search(sw = "Projektmanagement")

  expect_s3_class(results, "tbl_df")
})

test_that("weiterbildungssuche_facetten returns a tibble", {
  # Skip: API returns 403 Forbidden - may require browser-based auth
  skip("weiterbildungssuche API returns 403")
  skip_if_offline()
  skip_on_cran()

  results <- weiterbildungssuche_facetten(sw = "IT")

  expect_s3_class(results, "tbl_df")
})
