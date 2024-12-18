#' Get the proportion of the budget for GFCH, principale organization and third party
#'
#' @param data Tibble. Raw data about projects, with the good columns names.
#'
#' @importFrom dplyr mutate across rowwise case_when ungroup
#' @importFrom tidyselect starts_with
#'
#' @return A tibble with 3 columns about the proportion of the budget paid by each actor
#'
#' @noRd
get_prop_budget <- function(data) {
  data |>
    rowwise() |>
    mutate(
      total_budget = sum(
        budget_orga,
        budget_third_party,
        budget_gfch,
        na.rm = TRUE
      ),
      across(
        starts_with("budget_"),
        ~ .x / total_budget,
        .names = "prop_{.col}"
      ),
      across(
        starts_with("prop_"),
        ~ case_when(
          is.na(.x) ~ 0,
          TRUE ~ .x
        )
      )
    ) |>
    ungroup()
}
