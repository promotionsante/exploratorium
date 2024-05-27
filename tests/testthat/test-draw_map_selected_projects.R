test_that("draw_map_selected_projects() returns a leaflet object", {
  expect_s3_class(
    draw_map_selected_projects(
      projects_data_sf = dummy_project_data_sf()
    ),
    c("leaflet", "htmlwidget")
  )
})
