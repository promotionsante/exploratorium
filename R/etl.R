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
