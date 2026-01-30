test_that("dip bundestag endpoints return tibbles", {
  skip_if_offline()
  skip_on_cran()
  skip_if(Sys.getenv("DIP_BUNDESTAG_API_KEY") == "", "DIP_BUNDESTAG_API_KEY not set")

  results <- dip_bundestag_vorgang_list()
  expect_s3_class(results, "tbl_df")
})
