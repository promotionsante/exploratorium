#' Prepare the projects data in FR and DE to be included in the app as .rds files
#'
#' @param pkg_dir Character. Path to the package (must contain a data-raw folder).
#'
#' @importFrom cli cli_process_start cli_alert cli_process_done
#' @importFrom readr write_csv
#' @importFrom dplyr inner_join rename
#' @export
#'
#' @return A list with the projects data in FR and DE.
prepare_app_data <- function(
  pkg_dir = system.file(package = "exploratorium")) {
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

  cli_alert("Add the proportion of the budget")
  data_with_prop_budget <- data_import |>
    get_prop_budget()

  raw_features <- retrieve_project_features_from_promotion_digitale_db()

  cli_alert("Saving cantons by project dictionary")
  dic_cantons_by_project <- compute_dic_cantons_by_project(
    raw_features_df = raw_features
  )
  write_csv(
    x = dic_cantons_by_project,
    file = file.path(
      app_sys("data-projects"),
      "dic_cantons_by_project.csv"
    )
  )

  cli_alert("Add topics")
  feature_topic <- raw_features |>
    derive_feature_binary_columns(
      variable = "topic"
    ) |>
    rename(
      topic_respiratory_diseases = chronic_respiratory_diseases,
      topic_diabetes = diabetes,
      topic_cardio_diseases = cardiovascular_disease_,
      topic_cancers = cancer,
      topic_musculoskeletal_diseases = musculoskeletal_diseases,
      topic_mental_diseases = mental_illness,
      topic_addictions = addiction,
      topic_other_ncd = other_ncd,
      topic_other = other
    )
  data_with_topics <- feature_topic |>
    inner_join(data_with_prop_budget, by = "short_title")

  cli_alert("Add risk factors")
  feature_risk_factors <- raw_features |>
    derive_feature_binary_columns(
      variable = "risk_factors"
    )
  # prefix names with risk_factor to be later able to select all related columns
  names(feature_risk_factors) <- sub(
    pattern = "^(?!short_title$)(\\w+)$",
    replacement = "risk_factor_\\1",
    x = names(feature_risk_factors),
    perl = TRUE
  )
  data_with_risk_factors <- feature_risk_factors |>
    inner_join(data_with_topics, by = "short_title")

  cli_alert("Add PI1")
  feature_pi1 <- raw_features |>
    derive_feature_binary_columns(
      variable = "priority_areas_for_intervention_main"
    ) |>
    rename(
      pi_1_interfaces = `interfaces_within_health_care_and_between_health_care,_public_health_and_the_community`,
      pi_1_health_pathways = `collaboration,_interprofessionality,_multiprofessionality`,
      pi_1_self_gestion = `self-management_of_chronic_diseases_and_of_addiction_problems_and/or_mental_illnesses`
    )
  data_with_pi1 <- feature_pi1 |>
    inner_join(data_with_risk_factors, by = "short_title")

  cli_alert("Add PI2")
  feature_pi2 <- raw_features |>
    derive_feature_binary_columns(
      variable = "priority_areas_for_intervention_crosssection"
    ) |>
    rename(
      pi_2_training = `education,_training_and_continuing_education_of_health_professionals`,
      pi_2_new_tech = `new_financing_models_(hybrid_financing,_incentive_systems)`,
      pi_2_econom = `new_technologies_(especially_in_the_area_of_data/outcomes,_ehealth_and_mhealth)`
    )
  data_with_pi2 <- feature_pi2 |>
    inner_join(data_with_pi1, by = "short_title")

  cli_alert("Add the coordinates of the main organization")
  data_with_coord <- data_with_pi2 |>
    memoised_get_coord_main_resp_orga()

  cli_alert("Add the canton of the main organization")
  data_with_cantons <- data_with_coord |>
    get_canton_main_resp_orga()

  cli_alert("Translate data")
  data_translated <- data_with_cantons |>
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
