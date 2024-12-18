test_that("Test that the preparation of the projects data is ok", {

  # Load the toy datasets
  data("toy_data_pgv")
  data("toy_dic_variables")
  data("toy_dic_cantons")
  data("toy_cantons_sf")

  # Create a temp folder with data-projects-raw and ata-projects subfolder
  my_temp_dir <- tempfile("test-prepare-data")
  dir.create(my_temp_dir)
  dir.create(file.path(my_temp_dir, "data-projects-raw"))
  dir.create(file.path(my_temp_dir, "data-projects"))

  # Save the toy PGV file inside
  writexl::write_xlsx(toy_data_pgv,
                      file.path(my_temp_dir,
                                "data-projects-raw",
                                "toy_PGV.xlsx"))

  # Prepare the data
  prepare_app_data(
    name_raw_file = "toy_PGV.xlsx",
    pkg_dir = my_temp_dir,
    dic_variables = toy_dic_variables,
    dic_cantons = toy_dic_cantons,
    cantons_sf = toy_cantons_sf
  )

  # Read the created data
  projects_data_fr <- readRDS(
    file.path(
      my_temp_dir,
      "data-projects",
      "projects_fr.rds"
    )
  )

  # Perform usage checks on the data

  #' @description Testing that the object contains geometry of points (SF)
  expect_true(
    inherits(projects_data_fr |>
               select(geometry),
             "sf")
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
