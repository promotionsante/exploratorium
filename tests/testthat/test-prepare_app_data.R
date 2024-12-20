test_that("Test that the preparation of the projects data is ok", {
  skip_on_ci()

  # Create a temp folder with data-projects-raw and ata-projects subfolder
  my_temp_dir <- tempfile("test-prepare-data")
  dir.create(my_temp_dir)
  dir.create(file.path(my_temp_dir, "data-projects"))

  # Prepare the data
  prepare_app_data(
    pkg_dir = my_temp_dir
  )

  # Read the created data
  projects_data_fr <- readRDS(
    file.path(
      my_temp_dir,
      "data-projects",
      "projects_fr.rds"
    )
  )

  #' @description Testing that the object contains geometry of points (SF)
  expect_true(
    inherits(
      projects_data_fr |>
        select(geometry),
      "sf"
    )
  )

  #' @description Testing that the object contains geometry of points with crs = 4326
  expect_equal(
    object = sf::st_crs(
      projects_data_fr |>
        select(geometry)
    )$input,
    expected = "EPSG:4326"
  )

  # Delete the tempdir
  unlink(my_temp_dir, recursive = TRUE)
})
