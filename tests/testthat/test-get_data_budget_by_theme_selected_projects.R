test_that(
  "get_data_budget_by_theme_selected_projects() yield propre data.frame for FR data", {

  data("toy_projects_data_sf")

  data_graph_topic <- get_data_budget_by_theme_selected_projects(
    projects_data_sf = toy_projects_data_sf,
    language = "fr"
  )

  # Colnames and classes are the expected ones
  expect_equal(
    vapply(data_graph_topic, class, character(1)),
    c(
      name = "character",
      value = "numeric",
      value_tooltip = "character"
    )
  )

})

test_that(
  "get_data_budget_by_theme_selected_projects() yield propre data.frame for DE data", {

  data("toy_projects_data_sf")

  data_graph_topic <- get_data_budget_by_theme_selected_projects(
    projects_data_sf = toy_projects_data_sf,
    language = "de"
  )

  # Colnames and classes are the expected ones
  expect_equal(
    vapply(data_graph_topic, class, character(1)),
    c(
      name = "character",
      value = "numeric",
      value_tooltip = "character"
    )
  )

})
