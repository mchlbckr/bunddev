test_that("klinikatlas tidiers return expected shapes offline", {
  locations <- bunddev:::klinikatlas_tidy_records(list(
    list(name = "Klinik A", beds_number = 200, city = "Berlin"),
    list(name = "Klinik B", beds_number = 150, city = "Muenster")
  ))

  expect_s3_class(locations, "tbl_df")
  expect_true(all(c("name", "beds_number", "city") %in% names(locations)))
  expect_equal(nrow(locations), 2)

  search <- bunddev:::klinikatlas_tidy_search(list(
    results = list(
      list(
        id = 1,
        header = "Klinik A",
        address = "Berlin",
        distance = 3.4,
        detailLink = "/krankenhaussuche/krankenhaus/1/",
        content = list(items = list()),
        filters = list(fields = list()),
        sortings = list(fields = list()),
        metaInfos = list(searchResultCound = 1)
      )
    )
  ))

  expect_s3_class(search, "tbl_df")
  expect_true(all(c("id", "header", "content", "meta_infos") %in% names(search)))
  expect_true(is.list(search$content))
})

test_that("klinikatlas endpoints return expected types", {
  skip_if_offline()
  skip_on_cran()

  skip_if_endpoint_unavailable <- function(expr) {
    tryCatch(
      expr,
      error = function(e) {
        skip(conditionMessage(e))
      }
    )
  }

  locations <- skip_if_endpoint_unavailable(klinikatlas_locations())
  expect_s3_class(locations, "tbl_df")

  states <- skip_if_endpoint_unavailable(klinikatlas_states())
  expect_s3_class(states, "tbl_df")

  search <- skip_if_endpoint_unavailable(klinikatlas_search(params = list(
    "tx_solr[rows]" = 1,
    "tx_solr[start]" = 0,
    "tx_solr[searchlabel]" = "Berlin"
  )))
  expect_s3_class(search, "tbl_df")

  if (nrow(search) > 0) {
    html <- skip_if_endpoint_unavailable(
      klinikatlas_hospital_detail(search$id[[1]])
    )
    expect_type(html, "character")
  }
})
