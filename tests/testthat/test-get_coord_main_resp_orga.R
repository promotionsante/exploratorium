test_that("Test that the geocoding of the data is ok", {
  toy_data <-
    structure(
      list(
        city_code_main_resp_orga = c(
          "Z\u00fcrich",
          "Sion",
          "St. Gallen",
          NA,
          "Le Cerneux-Veusil",
          "Gen\u00e8ve"
        ),
        zip_code_main_resp_orga = c(
          "8000",
          "1950",
          "9000",
          NA,
          "2345",
          "1201"
        )
      ),
      row.names = c(
        NA,
        -6L
      ),
      class = c("tbl_df", "tbl", "data.frame")
    )

  #' @description Testing that there is a message if there is an issue
  expect_message(
    res_geocode <- get_coord_main_resp_orga(
      data = toy_data,
      cantons_sf = toy_cantons_sf
    ),
    regexp = "1 project.s is.are not associated to a city."
  )

  #' @description Testing that there is no error is an usual situation
  expect_error(
    res_geocode <- get_coord_main_resp_orga(
      data = toy_data,
      cantons_sf = toy_cantons_sf
    ),
    regexp = NA
  )
})
