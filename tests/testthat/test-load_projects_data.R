test_that("load_projects_data() returns sf objects", {
  projects_de <- load_projects_data(
    language = "de"
  )
  projects_fr <- load_projects_data(
    language = "fr"
  )
  expect_s3_class(projects_de, "sf")
  expect_s3_class(projects_fr, "sf")
})

test_that("load_projects_data() returns an error if unknow language provided", {
  expect_error(
    load_projects_data(
      language = "es"
    ),
    regexp = "Unknown language provided"
  )
})
