test_that(
  "get_data_budget_by_year_selected_projects() yield propre data.frame for FR data",
  {
    projects_data_sf <- read_projects_data("fr")

    data_graph_year <- get_data_budget_by_year_selected_projects(
      projects_data_sf = projects_data_sf,
      language = "fr"
    )

    # Colnames and classes are the expected ones
    expect_equal(
      vapply(data_graph_year, class, character(1)),
      c(
        name = "character",
        sum_value = "numeric",
        value = "numeric",
        value_tooltip = "character"
      )
    )
  }
)

test_that(
  "get_data_budget_by_year_selected_projects() yield propre data.frame for DE data",
  {
    projects_data_sf <- read_projects_data("de")

    data_graph_year <- get_data_budget_by_year_selected_projects(
      projects_data_sf = projects_data_sf,
      language = "de"
    )

    # Colnames and classes are the expected ones
    expect_equal(
      vapply(data_graph_year, class, character(1)),
      c(
        name = "character",
        sum_value = "numeric",
        value = "numeric",
        value_tooltip = "character"
      )
    )
  }
)
