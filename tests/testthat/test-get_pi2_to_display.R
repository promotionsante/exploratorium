test_that("get_pi2_to_display() returns well formed named vector in FR", {
  pi2_to_display <- get_pi2_to_display("fr")
  expect_length(
    pi2_to_display,
    3
  )
  expect_type(
    pi2_to_display,
    "character"
  )
  expect_true(
    !is.null(
      names(pi2_to_display)
    )
  )
  expect_true(
    all(
      !grepl(
        "^P2 : ",
        x = names(pi2_to_display)
      )
    )
  )
})

test_that("get_pi2_to_display() returns well formed named vector in DE", {
  pi2_to_display <- get_pi2_to_display("de")
  expect_length(
    pi2_to_display,
    3
  )
  expect_type(
    pi2_to_display,
    "character"
  )
  expect_true(
    !is.null(
      names(pi2_to_display)
    )
  )
  expect_true(
    all(
      !grepl(
        "^P2 *: ",
        x = names(pi2_to_display)
      )
    )
  )
})

