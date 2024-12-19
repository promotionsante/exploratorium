test_that("Test that the map for one project is ok", {
  projects_data_sf <- data.frame(
    short_title = "1+1=3  PGV03.038",
    geometry = sf::st_sfc(
      sf::st_point(
        c(8.5410422, 47.3744489)
      )
    )
  ) |>
    st_as_sf(
      crs = 4326
    )

  expect_s3_class(
    draw_map_focus_one_project(
      projects_data_sf = projects_data_sf,
      id_project = "1+1=3  PGV03.038"
    ),
    c("leaflet", "htmlwidget")
  )
})
