test_that("draw_map_base() returns a leaflet object", {
  expect_s3_class(
    draw_map_base(),
    c("leaflet", "htmlwidget")
  )
})
