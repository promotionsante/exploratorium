test_that("Test that the translation of the data is ok", {

  # Load the toy datasets
  data("toy_data_pgv")
  data("toy_dic_variables")
  data("toy_dic_values")

  # Import the raw data and perform the first preparations
  raw_data <- toy_data_pgv |>
    add_col_raw_data(
      dic_variables = toy_dic_variables
    ) |>
    clean_raw_data()

  # Get the translated data in FR and DE
  res_translated_data <- raw_data |>
    translate_values_in_data(
      cols_to_translate = c(
        "status",
        "topic",
        "risk_factors"
      ),
      dic_values = toy_dic_values
    )

  toy_data_fr <- res_translated_data$data_fr
  toy_data_de <- res_translated_data$data_de

  expect_equal(
    object = toy_data_fr |>
      dplyr::select(-c(status, topic, risk_factors)),
    expected = raw_data |>
      dplyr::select(-c(status, topic, risk_factors))
  )

  expect_equal(
    object = toy_data_fr |>
      dplyr::select(-c(status, topic, risk_factors)),
    expected = toy_data_de |>
      dplyr::select(-c(status, topic, risk_factors))
  )

  expect_equal(
    object = lengths(
      gregexpr(", ", toy_data_fr$topic, fixed = TRUE)
      ),
    expected = lengths(
      gregexpr(", ", toy_data_de$topic, fixed = TRUE)
      )
  )

  expect_equal(
    object = lengths(
      gregexpr(", ", toy_data_fr$risk_factors, fixed = TRUE)
      ),
    expected = lengths(
      gregexpr(", ", toy_data_de$risk_factors, fixed = TRUE)
      )
  )

})
