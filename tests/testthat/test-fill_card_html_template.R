
test_that("FR app titles are correct", {

  list_titles <- get_dic_titles_app(
    language = "fr"
  )

  expected_list_titles <- list(
    project_start_year_title = "Année de lancement",
    project_project_manager_title = "Responsable du projet<br>PSCH",
    project_main_orga_title = "Organisation responsable",
    project_advancement = "Avancement",
    project_description_title = "Description",
    project_theme_title = "Thèmes",
    project_risk_title = "Facteurs de risque",
    project_budget_title = "Budget total",
    project_prop_budget_title = "Répartition du budget"
  )

  expect_equal(
    list_titles,
    expected_list_titles
  )

})

test_that("DE app titles are correct", {

  list_titles <- get_dic_titles_app(
    language = "de"
  )

  expected_list_titles <- list(
      project_start_year_title = "Projektstart",
      project_project_manager_title = "Projektbegleitung<br>GFCH",
      project_main_orga_title = "Hauptverantwortliche Organisation",
      project_advancement = "Förderung",
      project_description_title = "Beschreibung",
      project_theme_title = "Thema",
      project_risk_title = "Risikofaktoren",
      project_budget_title = "Gesamtbudget",
      project_prop_budget_title = "Verteilung der Projektfinanzierung"
    )

  expect_equal(list_titles,
    expected_list_titles
  )

})

test_that("project card template in properly filled", {
  html_card <- fill_card_html_template(
    id_project = "1+1=3",
    data_projects = read_projects_data(language = "de"),
    language = "de"
  )
  expect_snapshot(html_card)
})
