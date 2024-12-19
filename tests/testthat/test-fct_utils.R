test_that("read_cantons_sf works", {
  cantons_sf <- read_cantons_sf()

  expect_equal(
    colnames(cantons_sf),
    c(
      "GID_1",
      "GID_0",
      "COUNTRY",
      "NAME_1",
      "VARNAME_1",
      "NL_NAME_1",
      "TYPE_1",
      "ENGTYPE_1",
      "CC_1",
      "HASC_1",
      "ISO_1",
      "geometry"
    )
  )

  expect_equal(
    dim(cantons_sf),
    c(26L, 12L)
  )

  expect_s3_class(
    cantons_sf,
    c("sf", "data.frame")
  )
})

test_that("Test that the reading of projects data works", {
  expect_error(
    data_projects_fr <- read_projects_data(
      language = "fr"
    ),
    regexp = NA
  )

  expect_true(
    inherits(data_projects_fr, "data.frame")
  )

  expect_error(
    data_projects_de <- read_projects_data(
      language = "de"
    ),
    regexp = NA
  )

  expect_true(
    inherits(data_projects_de, "data.frame")
  )
})

test_that("psch color function return proper color", {
  expect_equal(
    psch_blue(),
    "#578397"
  )
  expect_equal(
    psch_orange(),
    "#f59300"
  )
})
