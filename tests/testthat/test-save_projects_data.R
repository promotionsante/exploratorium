test_that("Test that the saving of the data in inst works", {
  # Create a temp folder with data subfolder
  my_temp_dir <- tempfile("test-export-data")
  dir.create(my_temp_dir)
  dir.create(file.path(my_temp_dir, "data-projects"))

  # Create toy lists
  toy_list_ok <- list(
    data_fr = iris,
    data_de = iris
  )

  toy_list_nok <- list(
    data_frzd = iris,
    data_defe = iris
  )

  #' @description Testing that there is an error of the list does not contain the object data_fr and data_de
  expect_error(
    object = save_projects_data(
      toy_list_nok,
      pkg_dir = my_temp_dir
    ),
    regexp = "The object to be saved does not contain FR and DE data"
  )

  #' @description Testing that the export is ok
  expect_message(
    object = save_projects_data(
      toy_list_ok,
      pkg_dir = my_temp_dir
    ),
    regexp = "has been updated at"
  )

  unlink(my_temp_dir, recursive = TRUE)
})
