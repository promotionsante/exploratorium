test_that("filter_projects_data() returns sf objects", {
  projects_de <- read_projects_data(
    language = "de"
  )
  projects_fr <- read_projects_data(
    language = "fr"
  )
  expect_s3_class(filter_projects_data(projects_de), "sf")
  expect_s3_class(filter_projects_data(projects_fr), "sf")
})
