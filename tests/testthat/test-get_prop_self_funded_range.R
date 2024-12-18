test_that("get_prop_self_funded_range() yield well formed range", {
  projects_data_sf <- data.frame(
    prop_budget_orga = c(0, 0.671)
  )
  budget_range <- get_prop_self_funded_range(projects_data_sf)
  expect_equal(
    budget_range,
    c(0, 68)
  )
})
