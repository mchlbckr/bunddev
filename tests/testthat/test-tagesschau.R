test_that("tagesschau helpers return tibbles", {
  skip_if_offline()
  skip_on_cran()

  homepage <- bunddev_tagesschau_homepage(flatten = TRUE, flatten_mode = "json")
  expect_s3_class(homepage, "tbl_df")

  news <- bunddev_tagesschau_news(flatten = TRUE, flatten_mode = "json")
  expect_s3_class(news, "tbl_df")

  channels <- bunddev_tagesschau_channels(flatten = TRUE, flatten_mode = "json")
  expect_s3_class(channels, "tbl_df")

  unnest_news <- bunddev_tagesschau_news(flatten = TRUE, flatten_mode = "unnest")
  expect_s3_class(unnest_news, "tbl_df")
})
