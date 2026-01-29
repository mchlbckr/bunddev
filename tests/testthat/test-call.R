test_that("bunddev_call performs a request", {
  skip_if_offline()
  skip_on_cran()

  endpoints <- bunddev_endpoints("abfallnavi")
  candidates <- dplyr::filter(
    endpoints,
    method == "get",
    !stringr::str_detect(path, "\\{")
  )

  if (nrow(candidates) == 0) {
    skip("No suitable endpoint without path params.")
  }

  operation_id <- candidates$operation_id[[1]]
  response <- bunddev_call("abfallnavi", operation_id, parse = "text")
  expect_type(response, "character")
  expect_true(nchar(response) > 0)
})
