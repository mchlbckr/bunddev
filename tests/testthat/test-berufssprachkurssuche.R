test_that("berufssprachkurssuche search returns tibble", {
  skip_if_offline()
  skip_on_cran()

  key <- Sys.getenv("BERUFSSPRACHKURSSUCHE_API_KEY")
  if (key == "") {
    skip("BERUFSSPRACHKURSSUCHE_API_KEY not set")
  }

  bunddev_auth_set("berufssprachkurssuche", type = "api_key", env_var = "BERUFSSPRACHKURSSUCHE_API_KEY")

  results <- berufssprachkurssuche_search(params = list(page = 0, systematiken = "MC"))
  expect_s3_class(results, "tbl_df")
})
