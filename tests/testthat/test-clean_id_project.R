test_that("Test that the cleaning of the id of a project works", {
  expect_equal(
    object = clean_id_project(
      id_project = "FM_ProPCC+"
    ),
    expected = "FMProPCC"
  )

  expect_equal(
    object = clean_id_project(
      id_project = "Sturzprävention/ in der Spitex"
    ),
    expected = "SturzpraventioninderSpitex"
  )
})
