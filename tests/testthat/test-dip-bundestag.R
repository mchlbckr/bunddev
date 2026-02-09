test_that("dip bundestag endpoints return tibbles", {
  skip_if_offline()
  skip_on_cran()

  if (Sys.getenv("DIP_BUNDESTAG_API_KEY") == "") {
    Sys.setenv(DIP_BUNDESTAG_API_KEY = "OSOegLs.PR2lwJ1dwCeje9vTj7FPOt3hvpYKtwKkhw")
  }

  results <- dip_bundestag_vorgang_list()
  expect_s3_class(results, "tbl_df")
  expect_true(all(c("num_found", "cursor", "documents") %in% names(results)))
})
