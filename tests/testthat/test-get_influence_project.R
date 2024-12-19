test_that("get_influence_project works", {
  data("toy_projects_data_sf")
  data("toy_cantons_sf")

  res_get_influence_project <- get_influence_project(
    projects_data_sf = toy_projects_data_sf,
    id_project = "1+1=3  PGV03.038",
    cantons_sf = toy_cantons_sf
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
