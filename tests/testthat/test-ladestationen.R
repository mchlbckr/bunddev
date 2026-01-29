test_that("ladestationen query returns a tibble", {
  skip_if_offline()
  skip_on_cran()

  token <- Sys.getenv("LADESTATIONEN_TOKEN")
  if (token == "") {
    skip("LADESTATIONEN_TOKEN not set")
  }

  geometry <- jsonlite::toJSON(
    list(
      xmin = 13.3,
      ymin = 52.4,
      xmax = 13.5,
      ymax = 52.6,
      spatialReference = list(wkid = 4326)
    ),
    auto_unbox = TRUE
  )

  results <- ladestationen_query(params = list(
    geometry = geometry,
    geometryType = "esriGeometryEnvelope",
    where = "1=1",
    outFields = "*",
    outSR = 4326,
    f = "json",
    returnGeometry = "false",
    resultRecordCount = 1,
    token = token
  ))

  expect_s3_class(results, "tbl_df")
})
