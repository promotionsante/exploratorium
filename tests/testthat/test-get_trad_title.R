test_that("Test that the translation of a title works", {
  data("toy_dic_titles_pages")

  expect_equal(
    object = get_trad_title(
      title_id = "project_start_year_title",
      language = "fr",
      dic_titles_pages = toy_dic_titles_pages
    ),
    expected = "Année de lancement"
  )

  expect_equal(
    object = get_trad_title(
      title_id = "project_start_year_title",
      language = "de",
      dic_titles_pages = toy_dic_titles_pages
    ),
    expected = "Projektstart"
  )
})
