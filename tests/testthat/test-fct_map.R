test_that("draw_leaflet_map() returns a leaflet object", {
  expect_s3_class(
    draw_leaflet_map(),
    c("leaflet", "htmlwidget")
  )
})
