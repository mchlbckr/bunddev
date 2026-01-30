test_that("interpol endpoints return tibbles", {
  skip_if_offline()
  skip_on_cran()
  skip_if(Sys.getenv("BUNDDEV_RUN_INTERPOL") != "true", "BUNDDEV_RUN_INTERPOL not set")

  red <- interpol_red_notices(params = list(resultPerPage = 1, page = 1))
  expect_s3_class(red, "tbl_df")

  yellow <- interpol_yellow_notices(params = list(resultPerPage = 1, page = 1))
  expect_s3_class(yellow, "tbl_df")

  un <- interpol_un_notices(params = list(resultPerPage = 1, page = 1))
  expect_s3_class(un, "tbl_df")
})
