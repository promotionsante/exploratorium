globalVariables(unique(c(
  # get_coord_main_resp_orga:
  "city_code_main_resp_orga", "country", "latitude", "longitude",
  "zip_code_main_resp_orga",
  # get_canton_main_resp_orga:
  "id_canton", "short_title", "HASC_1", "geometry", "short_titleextra",
  # get_nb_cantons_influenced:
  "geo_range",
  # draw_map_focus_one_project:
  "NAME_1", "target_cantons", "geo_range_id",
  # get_id_cantons_influenced:
  "de", "geo_range_id", "id",
  # mod_map_server:
  "toy_projects_data_sf",
  # create_skeleton_dic
  "value",
  # translate_values_in_col
  "col_translated",
  # consolidate_topic_data
  "name_variable", "topic", "topic_value", "none", "name_col_in_raw_data",
  # filter_projects_data
  "prop_budget_orga", "total_budget",
  # get_data_budget_by_theme_selected_projects
  "name", "present", "value_tooltip",
  # get_data_budget_by_year_selected_projects
  "funding_round", "sum_value", "budget_gfch",
  # compute_dic_cantons_by_project:
  "database", "feature_value", "feature_variable",
  # derive_feature_binary_columns:
  "feature_value", "feature_variable",
  # get_prop_budget:
  "budget_orga", "budget_third_party",
  # prepare_app_data:
  "addiction", "cancer", "cardiovascular_disease_", "chronic_respiratory_diseases", "collaboration,_interprofessionality,_multiprofessionality", "diabetes", "education,_training_and_continuing_education_of_health_professionals", "interfaces_within_health_care_and_between_health_care,_public_health_and_the_community", "mental_illness", "musculoskeletal_diseases", "new_financing_models_(hybrid_financing,_incentive_systems)", "new_technologies_(especially_in_the_area_of_data/outcomes,_ehealth_and_mhealth)", "other", "other_ncd", "self-management_of_chronic_diseases_and_of_addiction_problems_and/or_mental_illnesses",
  # retrieve_project_data_from_promotion_digitale_db:
  "city", "description", "end_date", "first_name", "funding_round_id", "gfch_share_approved", "id_project_budget", "last_name", "main_resp_orga", "other_funding_approved", "postal_code", "project_support_gfch", "share_responsible_organization_approved", "start_date", "status", "type",
  # retrieve_project_features_from_promotion_digitale_db:
  "code_feature_config", "code_feature_type_config", "id_short_title", "names_feature_config", "status", "type",
  # translate_values_in_col:
  "status",
  NULL
)))

# We need a dummy binding to be able to mock a function from {base}
# Needed for tests/testthat/test-compute_project_completion_percentage.R
Sys.Date <- NULL
