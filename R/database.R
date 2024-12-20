#' Connect to Promotion Digitale database
#'
#' @importFrom DBI dbConnect
#' @importFrom RPostgres Postgres
#' @noRd
connect_to_promotion_digitale_db <- function() {
  DBI::dbConnect(
    drv = RPostgres::Postgres(),
    host = Sys.getenv("DB_HOST", "localhost"),
    port = Sys.getenv("DB_PORT", "5433"),
    user = Sys.getenv("DB_USER", "postgres"),
    password = Sys.getenv("DB_PASSWORD", "postgres")
  )
}

#' Retrieve project data from Promotion Digitale
#'
#' @return A tibble containing the combined data from multiple tables with the following columns:
#' \item{id}{Dossier ID}
#' \item{short_title}{Short title of the dossier}
#' \item{description}{Description of the dossier}
#' \item{status}{Status of the dossier (CANCELED, FINISHED, IMPLEMENTATION)}
#' \item{start_date}{Start date of the dossier}
#' \item{end_date}{End date of the dossier}
#' \item{funding_round}{Name of the funding round}
#' \item{main_resp_orga}{Name of the main responsible organization}
#' \item{city}{City of the main responsible organization}
#' \item{postal_code}{Postal code of the main responsible organization}
#' \item{project_support_gfch}{Full name of the GFCH responsible person}
#' \item{share_responsible_organization_approved}{Approved share of the responsible organization}
#' \item{other_funding_approved}{Approved other funding}
#' \item{gfch_share_approved}{Approved GFCH share}
#'
#' @importFrom dplyr filter select inner_join mutate tbl collect across case_when
#' @importFrom withr local_db_connection
#' @noRd
retrieve_project_data_from_promotion_digitale_db <- function() {
  con <- withr::local_db_connection(
    con = connect_to_promotion_digitale_db()
  )

  pgv_db_dossier <- tbl(con, "dossier") |>
    dplyr::filter(
      type == "PF_PGV",
      status %in% c("CANCELED", "FINISHED", "IMPLEMENTATION")
    ) |>
    select(
      id,
      short_title,
      description,
      status,
      start_date,
      end_date,
      funding_round_id
    )

  pgv_db_funding_round <- pgv_db_dossier |>
    inner_join(
      tbl(con, "funding_round") |>
        select(
          id,
          funding_round = name
        ),
      by = c("funding_round_id" = "id"),
      suffix = c("_dossier", "_funding_round")
    )

  pgv_oraganization <- pgv_db_funding_round |>
    inner_join(
      tbl(con, "project_base"),
      by = c("id" = "dossier_id"),
      suffix = c("_dossier", "_project_base")
    ) |>
    inner_join(
      tbl(con, "organization") |>
        select(
          id,
          main_resp_orga = name,
          city,
          postal_code
        ),
      by = c("responsible_organization_id" = "id"),
      suffix = c("_dossier", "_organization")
    )

  pgv_db_project_support_gfch <- pgv_oraganization |>
    inner_join(
      tbl(con, "user") |> select(id, first_name, last_name),
      by = c("gfch_responsible_id" = "id"),
    ) |>
    mutate(
      project_support_gfch = paste(first_name, last_name)
    )

  pgv_db_budget <- pgv_db_project_support_gfch |>
    inner_join(
      tbl(con, "project_budget"),
      by = c("id_project_base" = "project_base_id"),
      suffix = c("", "_project_budget")
    )

  pgv_db_all_one_to_one_raw <- pgv_db_budget |>
    select(
      id,
      short_title,
      description,
      status,
      project_start = start_date,
      project_end = end_date,
      funding_round,
      main_resp_orga,
      city_code_main_resp_orga = city,
      zip_code_main_resp_orga = postal_code,
      project_support_gfch,
      budget_orga = share_responsible_organization_approved,
      budget_third_party = other_funding_approved,
      budget_gfch = gfch_share_approved,
      -id_project_budget,
    ) |>
    collect()

  pgv_db_all_one_to_one <- pgv_db_all_one_to_one_raw |>
    # NAs in budget columns correspond to 0s
    mutate(
      across(
        starts_with("budget"),
        ~ case_when(
          is.na(.x) ~ 0,
          TRUE ~ .x
        )
      )
    )

  return(pgv_db_all_one_to_one)
}


#' Retrieve project features from Promotion Digitale db
#'
#' @return A tibble containing the project features with the following columns:
#' \item{id}{Dossier ID}
#' \item{short_title}{Short title of the dossier}
#' \item{feature_variable}{Feature variable code}
#' \item{feature_value}{Feature value code}
#' \item{translations}{Feature translations}
#'
#' @importFrom dplyr filter select inner_join mutate tbl collect
#' @noRd
retrieve_project_features_from_promotion_digitale_db <- function() {
  con <- withr::local_db_connection(
    con = connect_to_promotion_digitale_db()
  )
  pgv_features <- tbl(con, "dossier") |>
    dplyr::filter(
      type == "PF_PGV",
      status %in% c("CANCELED", "FINISHED", "IMPLEMENTATION")
    ) |>
    select(
      id,
      short_title
    ) |>
    inner_join(
      tbl(con, "project_base"),
      by = c("id" = "dossier_id"),
      suffix = c("_dossier", "_project_base")
    ) |>
    # Avoid losing the dossier id in subsequent joins
    mutate(
      id_short_title = id
    ) |>
    inner_join(
      tbl(con, "feature_base"),
      by = c("feature_base_id" = "id")
    ) |>
    inner_join(
      tbl(con, "feature_value"),
      by = c("feature_base_id" = "feature_base_id"),
      suffix = c("_feature_base", "_feature_value")
    ) |>
    inner_join(
      tbl(con, "feature_config"),
      by = c("feature_config_id" = "id"),
      suffix = c("_feature_value", "_feature_config")
    ) |>
    inner_join(
      tbl(con, "feature_type_config") |>
        filter(
          code %in% c(
            "project_reach",
            "topic",
            "priority_areas_for_intervention_main",
            "priority_areas_for_intervention_crosssection",
            "risk_factors"
          )
        ),
      by = c("feature_type_id" = "id"),
      suffix = c("_feature_config", "_feature_type_config")
    ) |>
    select(
      id = id_short_title,
      short_title,
      feature_variable = code_feature_type_config,
      feature_value = code_feature_config,
      translations = names_feature_config
    ) |>
    collect()

  return(pgv_features)
}
