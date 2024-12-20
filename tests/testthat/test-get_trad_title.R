test_that("Test that the translation of a title works", {
  expect_equal(
    object = get_trad_title(
      title_id = "project_start_year_title",
      language = "fr"
    ),
    expected = "Année de lancement"
  )

  expect_equal(
    object = get_trad_title(
      title_id = "project_start_year_title",
      language = "de"
    ),
    expected = "Projektstart"
  )
})
