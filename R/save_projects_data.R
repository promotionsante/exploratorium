#' Save the prepared data (FR and DE versions) as .rds objects in the package
#'
#' @param list_data_fr_de List. With 2 tibbles corresponding to data in FR and data in DE.
#' @param pkg_dir Character. Path to the package.
#'
#' @importFrom purrr walk
#'
#' @return Nothing, used for side effect. Save 2 rds files in the package.
#'
#' @noRd
save_projects_data <- function(
  list_data_fr_de,
  pkg_dir = system.file(package = "exploratorium")
) {
  # Check that the list contains 2 tibbles (FR and DE)
  data_fr_and_de_in_names <- all(
    c("data_fr", "data_de") %in% names(list_data_fr_de)
  )

  if (isFALSE(data_fr_and_de_in_names)) {
    stop(
      paste(
        "The object to be saved does not contain FR and DE data",
        "Please check the origin of this issue",
        sep = "\n"
      )
    )
  }

  # Save FR data
  saveRDS(
    object = list_data_fr_de$data_fr,
    file = file.path(
      pkg_dir,
      "data-projects",
      "projects_fr.rds"
    )
  )

  # Save DE data
  saveRDS(
    object = list_data_fr_de$data_de,
    file = file.path(
      pkg_dir,
      "data-projects",
      "projects_de.rds"
    )
  )

  # Print a message about the time of modification
  available_files_in_data <- list.files(
    file.path(
      pkg_dir,
      "data-projects"
    )
  )

  c("projects_fr.rds", "projects_de.rds") |>
    walk(
      function(.x) {
        if (isTRUE(.x %in% available_files_in_data)) {
          message(
            glue(
              "{.x} has been updated at {file.info(file.path(pkg_dir, \'data-projects\', .x))$mtime}"
            )
          )
        } else {
          message(
            glue(
              "{.x} does not exist in the inst/data folder"
            )
          )
        }
      }
    )
}
