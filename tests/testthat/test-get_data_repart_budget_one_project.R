test_that("get_data_repart_budget_one_project works for FR data", {
  projects_data_sf <- data.frame(
    short_title = "1+1=3  PGV03.038",
    budget_gfch = 2e+05,
    budget_orga = 25000,
    budget_third_party = 361720,
    prop_budget_gfch = 0.340878101990728,
    prop_budget_orga = 0.042609762748841,
    prop_budget_third_party = 0.616512135260431
  )

  data_repart_budget_one_proj_fr <- get_data_repart_budget_one_project(
    data_projects = projects_data_sf,
    id_project = "1+1=3  PGV03.038",
    language = "fr"
  )

  expect_equal(
    object = data_repart_budget_one_proj_fr,
    expected = structure(
      list(
        name = c("PSCH", "Organisation responsable", "Tiers"),
        value = c(
          prop_budget_gfch = 34.1,
          prop_budget_orga = 4.3,
          prop_budget_third_party = 61.7
        ),
        value_tooltip = c(
          budget_gfch = "200 000 CHF",
          budget_orga = "25 000 CHF",
          budget_third_party = "361 720 CHF"
        )
      ),
      row.names = c(NA, -3L),
      class = c("tbl_df", "tbl", "data.frame")
    )
  )
})

test_that("get_data_repart_budget_one_project works for DE data", {
  projects_data_sf <- data.frame(
    short_title = "1+1=3  PGV03.038",
    budget_gfch = 2e+05,
    budget_orga = 25000,
    budget_third_party = 361720,
    prop_budget_gfch = 0.340878101990728,
    prop_budget_orga = 0.042609762748841,
    prop_budget_third_party = 0.616512135260431
  )


  data_repart_budget_one_proj_de <- get_data_repart_budget_one_project(
    data_projects = projects_data_sf,
    id_project = "1+1=3  PGV03.038",
    language = "de"
  )

  expect_equal(
    object = data_repart_budget_one_proj_de,
    expected = structure(
      list(
        name = c("GFCH", "Haupt-Org", "Dritte"),
        value = c(
          prop_budget_gfch = 34.1,
          prop_budget_orga = 4.3,
          prop_budget_third_party = 61.7
        ),
        value_tooltip = c(
          budget_gfch = "200 000 CHF",
          budget_orga = "25 000 CHF",
          budget_third_party = "361 720 CHF"
        )
      ),
      row.names = c(NA, -3L),
      class = c("tbl_df", "tbl", "data.frame")
    )
  )
})
