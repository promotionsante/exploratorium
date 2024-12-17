#' Prepare the projects data in FR and DE to be included in the app as .rds files
#'
#' @param name_raw_file Character. Name of the raw data file.
#' @param pkg_dir Character. Path to the package (must contain a data-raw folder).
#' @param dic_variables Tibble. Variables dictionaries. Mainly used for examples and unit testing purpose.
#' @param dic_cantons Tibble. Canton dictionary. Mainly used for examples and unit testing purpose.
#' @param cantons_sf Sf data. Cantons geometry. Mainly used for examples and unit testing purpose.
#'
#' @importFrom glue glue
#' @importFrom here here
#' @importFrom cli cli_process_start cli_alert cli_process_done
#' @export
#'
#' @return A list with the projects data in FR and DE.
#' @examples
#' # Load the toy datasets
#' data("toy_data_pgv")
#' data("toy_dic_variables")
#' data("toy_dic_cantons")
#' data("toy_cantons_sf")
#'
#' # Create a temp folder with data-projects-raw and ata-projects subfolder
#' my_temp_dir <- tempfile("test-prepare-data")
#' dir.create(my_temp_dir)
#' dir.create(file.path(my_temp_dir, "data-projects-raw"))
#' dir.create(file.path(my_temp_dir, "data-projects"))
#'
#' # Save the toy PGV file inside
#' writexl::write_xlsx(
#'   toy_data_pgv,
#'   file.path(
#'     my_temp_dir,
#'     "data-projects-raw",
#'     "toy_PGV.xlsx"
#'   )
#' )
#'
#' # Prepare the data
#' prepare_app_data(
#'   name_raw_file = "toy_PGV.xlsx",
#'   pkg_dir = my_temp_dir,
#'   dic_variables = toy_dic_variables,
#'   dic_cantons = toy_dic_cantons,
#'   cantons_sf = toy_cantons_sf
#' )
#'
#' # Delete the tempdir
#' unlink(my_temp_dir, recursive = TRUE)
prepare_app_data <- function(
  name_raw_file = "PGV.xlsx",
  pkg_dir = system.file(package = "exploratorium"),
  dic_variables = NULL,
  dic_cantons = NULL,
  cantons_sf = NULL
) {
  cli_process_start(
    "Prepare projects_fr.rds and projects_de.rds"
  )

  cli_alert("Import the raw data")
  data_import <- retrieve_project_data_from_promotion_digitale_db()

  cli_alert("Clean raw data")
  data_import$city_code_main_resp_orga <- sub(
    pattern = "(Bern) \\d{2}",
    replacement = "\\1",
    x = data_import$city_code_main_resp_orga
  )

  cli_alert("Add the coordinates of the main organization")
  data_with_coord <- data_import |>
    memoised_get_coord_main_resp_orga(
      cantons_sf = cantons_sf
    )

  cli_alert("Add the canton of the main organization")
  data_with_cantons <- data_with_coord |>
    get_canton_main_resp_orga(
      cantons_sf = cantons_sf
    )

  cli_alert("Add the proportion of the budget")
  data_with_prop_budget <- data_with_cantons |>
    get_prop_budget()


  raw_features <- retrieve_project_features_from_promotion_digitale_db()

  cli_alert("Add topics")
  feature_topic <- raw_features |>
    derive_feature_binary_columns(
      variable = "topic"
    )
  names(feature_topic) <- sub(
    # Matches any entry but "short_title"
    pattern = "^(?!short_title$)(\\w+)$",
    replacement = "topic_\\1",
    x = names(feature_topic),
    perl = TRUE
  )
  data_with_topics <- feature_topic |>
    inner_join(data_with_prop_budget, by = "short_title")


  cli_alert("Add PI1")
  feature_pi1 <- raw_features |>
    derive_feature_binary_columns(
      variable = "priority_areas_for_intervention_main"
    )
  names(feature_pi1) <- sub(
    # Matches any entry but "short_title"
    pattern = "^(?!short_title$)(\\w+)$",
    replacement = "pi1_\\1",
    x = names(feature_pi1),
    perl = TRUE
  )
  data_with_pi1 <- feature_pi1 |>
    inner_join(data_with_topics, by = "short_title")

  cli_alert("Add PI2")
  feature_pi2 <- raw_features |>
    derive_feature_binary_columns(
      variable = "priority_areas_for_intervention_crosssection"
    )
  names(feature_pi2) <- sub(
    # Matches any entry but "short_title"
    pattern = "^(?!short_title$)(\\w+)$",
    replacement = "pi1_\\1",
    x = names(feature_pi2),
    perl = TRUE
  )
  data_with_pi2 <- feature_pi2 |>
    inner_join(data_with_pi1, by = "short_title")

  cli_alert("Translate data")
  data_translated <- data_with_pi2 |>
    translate_values_in_data(
      cols_to_translate = c(
        "status"
      )
    )

  cli_alert("Save the data")
  save_projects_data(
    list_data_fr_de = data_translated,
    pkg_dir = pkg_dir
  )

  cli_process_done(
    "Prepare projects_fr.rds and projects_de.rds"
  )
}
