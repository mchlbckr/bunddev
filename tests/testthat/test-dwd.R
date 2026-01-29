test_that("dwd helpers return tibbles", {
  skip_if_offline()
  skip_on_cran()

  crowd <- dwd_crowd_reports()
  expect_s3_class(crowd, "tbl_df")

  warnings <- dwd_warnings_nowcast()
  expect_s3_class(warnings, "tbl_df")

  stations <- dwd_station_overview("10865", flatten = TRUE, flatten_mode = "json")
  expect_s3_class(stations, "tbl_df")
})
