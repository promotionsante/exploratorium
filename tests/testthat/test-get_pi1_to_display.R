test_that("get_pi1_to_display() returns well formed named vector in FR", {
  pi1_to_display <- get_pi1_to_display("fr")
  expect_length(
    pi1_to_display,
    3
  )
  expect_type(
    pi1_to_display,
    "character"
  )
  expect_true(
    !is.null(
      names(pi1_to_display)
    )
  )
  expect_true(
    all(
      !grepl(
        "^P1 : ",
        x = names(pi1_to_display)
      )
    )
  )
})

test_that("get_pi1_to_display() returns well formed named vector in DE", {
  pi1_to_display <- get_pi1_to_display("de")
  expect_length(
    pi1_to_display,
    3
  )
  expect_type(
    pi1_to_display,
    "character"
  )
  expect_true(
    !is.null(
      names(pi1_to_display)
    )
  )
  expect_true(
    all(
      !grepl(
        "^P1 *: ",
        x = names(pi1_to_display)
      )
    )
  )
})
