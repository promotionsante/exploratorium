test_that("Test that the map for one project is ok", {

  data("toy_projects_data_sf")
  data("toy_cantons_sf")

  expect_s3_class(
    draw_map_focus_one_project(
      projects_data_sf = toy_projects_data_sf,
      id_project = "1+1=3  PGV03.038",
      cantons_sf = toy_cantons_sf
    ),
    c("leaflet", "htmlwidget")
  )

})
