test_that("coachingangebote search returns tibble", {
  skip_if_offline()
  skip_on_cran()

  key <- Sys.getenv("COACHINGANGEBOTE_API_KEY")
  if (key == "") {
    skip("COACHINGANGEBOTE_API_KEY not set")
  }

  bunddev_auth_set("coachingangebote", type = "api_key", env_var = "COACHINGANGEBOTE_API_KEY")

  results <- coachingangebote_search(params = list(mz = "SA 01"))
  expect_s3_class(results, "tbl_df")
})
