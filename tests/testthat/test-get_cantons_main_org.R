test_that("get_cantons_main_org() yields well-formed vector in FR", {
  projects_data_sf <- read_projects_data("fr")
  cantons_main_org <- get_cantons_main_org(projects_data_sf)
  expect_type(
    cantons_main_org,
    "character"
  )
  # No CH prefix
  expect_true(
    all(
      !grepl(
        pattern = "^CH\\.",
        names(cantons_main_org)
      )
    )
  )
  # No dupplicated canton id
  expect_equal(
    length(cantons_main_org),
    length(unique(cantons_main_org))
  )
})

test_that("get_cantons_main_org() yields well-formed vector in DE", {
  projects_data_sf <- read_projects_data("de")
  cantons_main_org <- get_cantons_main_org(projects_data_sf)
  expect_type(
    cantons_main_org,
    "character"
  )
  # No CH prefix
  expect_true(
    all(
      !grepl(
        pattern = "^CH\\.",
        names(cantons_main_org)
      )
    )
  )
  # No dupplicated canton id
  expect_equal(
    length(cantons_main_org),
    length(unique(cantons_main_org))
  )
})
