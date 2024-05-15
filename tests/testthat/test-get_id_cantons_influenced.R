test_that("Test that the detection of the id of the cantons influenced is ok", {

  data("toy_data_pgv")
  data("toy_dic_cantons")
  data("toy_dic_variables")

  toy_data <- toy_data_pgv |>
    add_col_raw_data(
      dic_variables = toy_dic_variables
    ) |>
    clean_raw_data()

  nb_cantons_geo_range <- toy_data |>
    mutate(
      geo_range = lengths(stringr::str_split(geo_range, ","))
    ) |> pull(geo_range)

  #' @description Testing that the detection is ok
  expect_error(
    res_id_cantons <- get_id_cantons_influenced(
      data = toy_data,
      dic_cantons = toy_dic_cantons
    ),
    regexp = NA
  )

  nb_cantons_geo_range_id <- res_id_cantons |>
    mutate(
      geo_range_id = lengths(stringr::str_split(geo_range_id, ","))
    ) |> pull(geo_range_id)

  #' @description Testing that the number of cantons detected is ok
  expect_equal(
    object = nb_cantons_geo_range_id,
    expected = nb_cantons_geo_range
  )

})
