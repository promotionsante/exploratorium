test_that("log_all_current_module_input works", {
  mock_session <- shiny::MockShinySession$new()
  mock_session$setInputs(x = 1, y = c("a", "b"))
  shiny::reactiveConsole(TRUE)

  header <-  capture.output(
    log_all_current_module_input(
      session = mock_session
    ),
    type = "output"
  )

  # Proper header
  expect_true(
    grepl(
      pattern = "Inputs value from: mock-session",
      x = header
    )
  )

  input_values <- capture.output(
    log_all_current_module_input(
      session = mock_session
    ),
    type = "message"
  )

  # Input values properly logged
  expect_true(
    all(
      grepl(
        pattern =  c("y: a, b|x: 1"),
        x = input_values
      )
    )
  )

  shiny::reactiveConsole(FALSE)
})
