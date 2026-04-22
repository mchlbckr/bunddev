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

  detail_html <- paste(
    "<html><body>",
    "<div class='c-hospital-map__map' id='js_hospital-map' data-location-latlng='50.1, 8.6'></div>",
    "<div class='c-hospital-map__info'>",
    "<address>Musterstraße 1, 12345 Berlin</address>",
    "<ul>",
    "<li><a href='https://example.org'>example.org</a></li>",
    "<li><a href='tel:+491234'>+49 1234</a></li>",
    "<li><a href='mailto:test@example.org'>test@example.org</a></li>",
    "<li><strong>Träger:</strong> öffentlich</li>",
    "<li class='location-size'><strong>Größe:</strong><small>Betten: 84 Betten (klein)</small></li>",
    "</ul></div>",
    "<h1>Klinik A</h1>",
    "<div id='content-menu-cases'><div class='ce-accordion__header__hidden-components'><div class='c-tacho-text__text'><strong>4.177</strong> (wenige)</div></div></div>",
    "<div id='content-menu-stuff'>",
    "<div class='c-tacho-text__text'><strong>36,60</strong> (weit überdurchschnittlich)</div>",
    "<p><strong>66</strong> Pflegekräfte in der unmittelbaren Patientenversorgung am Krankenhausstandort</p>",
    "</div>",
    "<div id='content-menu-departments'>",
    "<div class='ce-accordion__header__hidden-components'><strong>3</strong></div>",
    "</div>",
    "<div id='accordion-2-panel-2'><ul class='rte_ul'><li>Innere Medizin: <strong>100</strong></li><li>Chirurgie: <strong>50</strong></li></ul></div>",
    "</body></html>"
  )

  detail <- bunddev:::klinikatlas_tidy_detail(detail_html, id = 123)
  expect_s3_class(detail, "tbl_df")
  expect_equal(detail$id, 123L)
  expect_equal(detail$name, "Klinik A")
  expect_equal(detail$address, "Musterstraße 1, 12345 Berlin")
  expect_equal(detail$ownership, "öffentlich")
  expect_equal(detail$beds, 84L)
  expect_equal(detail$case_count, 4177L)
  expect_equal(detail$nursing_quotient, 36.6)
  expect_equal(detail$nursing_staff_direct_care, 66L)
  expect_equal(detail$department_count, 3L)
  expect_equal(detail$departments[[1]], c("Innere Medizin: 100", "Chirurgie: 50"))
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
    detail <- skip_if_endpoint_unavailable(
      klinikatlas_hospital_detail(search$id[[1]])
    )
    expect_s3_class(detail, "tbl_df")
    expect_equal(nrow(detail), 1)
    expect_true(all(c("id", "name", "address", "beds", "departments") %in% names(detail)))

    html <- skip_if_endpoint_unavailable(
      klinikatlas_hospital_detail(search$id[[1]], raw = TRUE)
    )
    expect_type(html, "character")
  }
})
