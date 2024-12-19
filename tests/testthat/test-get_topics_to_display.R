test_that("get_topics_to_display() works in FR", {
  topics_to_display <- get_topics_to_display(
    language = "fr"
  )

  expect_type(
    topics_to_display,
    "character"
  )

  # Other topics are featured at the very end of the vector
  id_other_topics <- grep("Andere|Autre", topics_to_display)
  expect_setequal(
    id_other_topics,
    seq(
      from = length(topics_to_display),
      length.out = length(id_other_topics),
      by = -1
    )
  )
})

test_that("get_topics_to_display() works in DE", {
  topics_to_display <- get_topics_to_display(
    language = "de"
  )

  expect_type(
    topics_to_display,
    "character"
  )

  # Other topics are featured at the very end of the vector
  id_other_topics <- grep("Andere|Autre", topics_to_display)
  expect_setequal(
    id_other_topics,
    seq(
      from = length(topics_to_display),
      length.out = length(id_other_topics),
      by = -1
    )
  )
})
