test_that("handelsregister search returns a tibble", {
  skip_if_offline()
  skip_on_cran()
  skip_if(Sys.getenv("BUNDDEV_RUN_HANDELSREGISTER") != "true")

  result <- bunddev_handelsregister_search("bunddev", safe = FALSE)
  expect_s3_class(result, "tbl_df")
})
