test_that("get_input_data_to_display() works", {
  expect_error(
    get_input_data_to_display(
      language = "fr",
      pattern = "^topic_"
    ),
    NA
  )
})
