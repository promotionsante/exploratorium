test_that("get_budget_range() yield well formed range in FR", {
  projects_data_sf <- read_projects_data("fr")
  budget_range <- get_budget_range(projects_data_sf)
  expect_length(
    budget_range,
    2
  )
  expect_type(
    budget_range,
    "double"
  )
})
test_that("get_budget_range() yield well formed range in DE", {
  projects_data_sf <- read_projects_data("de")
  budget_range <- get_budget_range(projects_data_sf)
  expect_length(
    budget_range,
    2
  )
  expect_type(
    budget_range,
    "double"
  )
})
