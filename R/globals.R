globalVariables(unique(
  c(
    # compute_dic_cantons_by_project:
    "database",
    "feature_value",
    "feature_variable",
    "id",
    "short_title",
    # derive_feature_binary_columns:
    "feature_value",
    "feature_variable",
    "short_title",
    "value",
    # draw_map_focus_one_project:
    "target_cantons",
    # fill_card_html_template:
    "presence",
    "short_title",
    "topic",
    # filter_projects_data:
    "id_canton",
    "prop_budget_orga",
    "total_budget",
    # get_canton_main_resp_orga:
    "geometry",
    "HASC_1",
    "id_canton",
    "latitude",
    "longitude",
    "short_title",
    "short_titleextra",
    # get_coord_main_resp_orga:
    "city_code_main_resp_orga",
    "country",
    "latitude",
    "longitude",
    "zip_code_main_resp_orga",
    # get_data_budget_by_theme_selected_projects:
    "name",
    "present",
    "total_budget",
    "value",
    "value_tooltip",
    # get_data_budget_by_year_selected_projects:
    "budget_gfch",
    "funding_round",
    "sum_value",
    "value",
    # get_project_items_from_binary_columns
    "item",
    # get_data_repart_budget_one_project:
    "short_title",
    # get_influence_project:
    "geometry",
    "HASC_1",
    "NAME_1",
    "short_title",
    "target_cantons",
    # get_prop_budget:
    "budget_gfch",
    "budget_orga",
    "budget_third_party",
    # get_trad_title:
    "id",
    # prepare_app_data:
    "addiction",
    "cancer",
    "cardiovascular_disease_",
    "chronic_respiratory_diseases",
    "collaboration,_interprofessionality,_multiprofessionality",
    "diabetes",
    "education,_training_and_continuing_education_of_health_professionals",
    "interfaces_within_health_care_and_between_health_care,_public_health_and_the_community",
    "mental_illness",
    "musculoskeletal_diseases",
    "new_financing_models_(hybrid_financing,_incentive_systems)",
    "new_technologies_(especially_in_the_area_of_data/outcomes,_ehealth_and_mhealth)",
    "other",
    "other_ncd",
    "self-management_of_chronic_diseases_and_of_addiction_problems_and/or_mental_illnesses",
    # retrieve_project_data_from_promotion_digitale_db:
    "city",
    "description",
    "end_date",
    "first_name",
    "funding_round",
    "funding_round_id",
    "gfch_share_approved",
    "id",
    "id_project_budget",
    "last_name",
    "main_resp_orga",
    "name",
    "other_funding_approved",
    "postal_code",
    "project_support_gfch",
    "share_responsible_organization_approved",
    "short_title",
    "start_date",
    "status",
    "type",
    # retrieve_project_features_from_promotion_digitale_db:
    "code_feature_config",
    "code_feature_type_config",
    "id",
    "id_short_title",
    "names_feature_config",
    "short_title",
    "status",
    "type"
  )
))

# We need a dummy binding to be able to mock a function from {base}
# Needed for tests/testthat/test-compute_project_completion_percentage.R
Sys.Date <- NULL
