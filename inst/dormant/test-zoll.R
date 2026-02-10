test_that("zoll_kurse returns a tibble", {
  skip_if_offline()
  skip_on_cran()

  results <- tryCatch(
    zoll_kurse(),
    error = function(e) {
      if (grepl("503|502|Service Unavailable", e$message)) {
        skip("zoll API temporarily unavailable (503)")
      }
      stop(e)
    }
  )

  expect_s3_class(results, "tbl_df")
  expect_gt(nrow(results), 0)
})

test_that("zoll_produktgruppen returns a tibble", {
  skip_if_offline()
  skip_on_cran()

  results <- tryCatch(
    zoll_produktgruppen(),
    error = function(e) {
      if (grepl("503|502|Service Unavailable", e$message)) {
        skip("zoll API temporarily unavailable (503)")
      }
      stop(e)
    }
  )

  expect_s3_class(results, "tbl_df")
})
