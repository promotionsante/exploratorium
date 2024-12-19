test_that("get_influence_project works", {
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


  res_get_influence_project <- get_influence_project(
    projects_data_sf = projects_data_sf,
    id_project = "1+1=3  PGV03.038"
  )

  expect_equal(
    object = names(res_get_influence_project),
    expected = c(
      "coord_sf_project",
      "cantons_sf_project",
      "cantons_influenced_lines"
    )
  )

  expect_true(
    inherits(res_get_influence_project$coord_sf_project, "sf")
  )

  expect_true(
    inherits(res_get_influence_project$cantons_sf_project, "sf")
  )

  expect_true(
    inherits(res_get_influence_project$cantons_influenced_lines, "sfc_LINESTRING")
  )
})
