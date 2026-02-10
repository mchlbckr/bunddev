test_that("interpol endpoints return tibbles", {
  skip_if_offline()
  skip_on_cran()

  red <- tryCatch(
    interpol_red_notices(params = list(resultPerPage = 1, page = 1)),
    error = function(e) {
      if (grepl("403|Forbidden", e$message)) {
        skip("interpol API returns 403 (access denied)")
      }
      stop(e)
    }
  )
  expect_s3_class(red, "tbl_df")

  yellow <- interpol_yellow_notices(params = list(resultPerPage = 1, page = 1))
  expect_s3_class(yellow, "tbl_df")

  un <- interpol_un_notices(params = list(resultPerPage = 1, page = 1))
  expect_s3_class(un, "tbl_df")
})
