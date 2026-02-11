test_that("entgeltatlas endpoint returns tibble", {
  skip_if_offline()
  skip_on_cran()
  skip_if(Sys.getenv("BUNDDEV_RUN_ENTGELTATLAS") != "true", "BUNDDEV_RUN_ENTGELTATLAS not set")
  skip_if(Sys.getenv("ENTGELTATLAS_API_KEY") == "", "ENTGELTATLAS_API_KEY not set")

  bunddev_auth_set("entgeltatlas", type = "api_key", env_var = "ENTGELTATLAS_API_KEY")

  data <- entgeltatlas_entgelte(
    "84304",
    params = list(r = 1, g = 1),
    flatten = TRUE
  )
  expect_s3_class(data, "tbl_df")
  if (nrow(data) > 0) {
    expect_true(all(c("kldb", "entgelt") %in% names(data)))
  }
})
