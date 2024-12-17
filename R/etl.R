#' @importFrom dplyr filter select
#' @importFrom readr write_csv
#' @noRd
save_dic_cantons_by_project <- function(
  raw_features_df,
  path
) {
  raw_features |>
    filter(feature_variable == "project_reach") |>
    select(short_title, geo_range = feature_value) |>
    readr::write_csv(
      x = _,
      file = path
    )
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
