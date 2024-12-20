#' @importFrom readr read_csv
#' @noRd
read_csv_in_inst <- function(inst_path) {
  read_csv(
    app_sys(
      inst_path
    ),
    show_col_types = FALSE
  )
}

#' @importFrom dplyr filter select inner_join
#' @importFrom readr read_csv write_csv
#' @noRd
compute_dic_cantons_by_project <- function(raw_features_df) {
  dic_cantons <- read_csv_in_inst("data-dic/dic_cantons.csv")

  raw_features_df |>
    filter(feature_variable == "project_reach") |>
    select(short_title, geo_range = feature_value) |>
    inner_join(
      select(dic_cantons, database, id),
      by = c("geo_range" = "database")
    ) |>
    select(short_title, geo_range_id = id)
}

#' @importFrom dplyr filter select mutate
#' @importFrom tidyr pivot_wider
#' @noRd
derive_feature_binary_columns <- function(raw_features_df, variable) {
  raw_features_df |>
    filter(feature_variable == variable) |>
    select(short_title, feature_value) |>
    mutate(
      value = TRUE
    ) |>
    tidyr::pivot_wider(
      names_from = feature_value,
      values_from = value,
      values_fill = list(value = FALSE)
    )
}
