test_that("compute_project_completion_percentage works", {
  with_mocked_bindings(
    code = {
      completion_percentage <- compute_project_completion_percentage(
        date_project_start = as.Date("2023-01-01"),
        date_project_end = as.Date("2026-12-31")
      )
    },
    Sys.Date = function() as.Date("2024-03-04")
  )
  expect_equal(
    completion_percentage,
    29
  )
})
