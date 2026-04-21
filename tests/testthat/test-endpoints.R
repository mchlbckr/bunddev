test_that("bunddev_endpoints returns endpoints", {
  skip_if_offline()
  skip_on_cran()

  endpoints <- bunddev_endpoints("abfallnavi")

  expect_s3_class(endpoints, "tbl_df")
  expect_true(all(c("method", "path", "operation_id", "summary") %in% names(endpoints)))
  expect_true(nrow(endpoints) > 0)
})

test_that("bunddev_endpoints returns klinikatlas endpoints", {
  skip_if_offline()
  skip_on_cran()

  endpoints <- tryCatch(
    bunddev_endpoints("klinikatlas"),
    error = function(e) {
      skip(conditionMessage(e))
    }
  )

  expect_s3_class(endpoints, "tbl_df")
  expect_true(nrow(endpoints) >= 8)
  expect_true("/searchresults/" %in% endpoints$path)
})
