test_that("Test that the translation for column status", {

  data_raw <- data.frame(
    status = c(
      "FINISHED",
      "IMPLEMENTATION",
      "CANCELED"
    ),
    geometry = sf::st_sfc(
      st_point(c(1,1)),
      st_point(c(1,1)),
      st_point(c(1,1))
    )
  ) |>
    st_as_sf()

  col_status_fr <- translate_values_in_col(
    data = data_raw,
    col_to_translate = "status",
    language = "fr"
  )

  expect_s3_class(
    col_status_fr,
    c("sf", "data.frame")
  )

  expect_equal(
    object = col_status_fr$status,
    expected = c(
      "Termin\u00e9",
      "En cours",
      "Annul\u00e9"
    )
  )

  col_status_de <- translate_values_in_col(
    data = data_raw,
    col_to_translate = "status",
    language = "de"
  )

  expect_s3_class(
    col_status_de,
    c("sf", "data.frame")
  )

  expect_equal(
    object = col_status_de$status,
    expected = c(
      "Abschluss",
      "Umsetzung",
      "Abbruch"
    )
  )

})

test_that("Test that the translation for topic", {

  data_raw <- data.frame(
    topic = c(
      "topic_respiratory_diseases",
      "topic_diabetes",
      "topic_cardio_diseases"
    ),
    geometry = sf::st_sfc(
      st_point(c(1,1)),
      st_point(c(1,1)),
      st_point(c(1,1))
    )
  ) |>
    st_as_sf()

  col_status_fr <- translate_values_in_col(
    data = data_raw,
    col_to_translate = "topic",
    language = "fr",
    dictionary = "dic_variables.csv"
  )

  expect_s3_class(
    col_status_fr,
    c("sf", "data.frame")
  )

  expect_equal(
    object = col_status_fr$topic,
    expected = c(
      "Maladies respiratoires",
      "Diabète",
      "Maladies cardiovasculaires"
    )
  )

  col_status_de <- translate_values_in_col(
    data = data_raw,
    col_to_translate = "topic",
    language = "de",
    dictionary = "dic_variables.csv"
  )

  expect_s3_class(
    col_status_de,
    c("sf", "data.frame")
  )

  expect_equal(
    object = col_status_de$topic,
    expected = c(
      "Atemwegserkrankungen",
      "Diabetes",
      "Herz-Kreislauf-Erkrankungen"
    )
  )

})
