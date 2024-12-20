#' Filter projects data
#'
#' Main function that powers the filtering of  mod_projects_selection_*()
#'
#' @param projects_data_sf A sf data.frame.
#' @param vec_topics A character vector of topics
#' @param range_budget A numeric vector of size two defining the lower and
#' upper bound of budget.
#' @param range_self_funded_budget A numeric vector of size two defining the lower and
#'  upper bound of self-funded budget.
#' @param canton_main_resp_orga A character vector containing the names of the
#' cantons of interest.
#'
#' @importFrom dplyr filter if_any contains between
#'
#' @return A sf data.frame
#'
#' @noRd
filter_projects_data <- function(
  projects_data_sf,
  vec_topics = NULL,
  vec_pi_1 = NULL,
  vec_pi_2 = NULL,
  range_budget = NULL,
  range_self_funded_budget = NULL,
  cantons_main_org = NULL
) {
  if (
    !is.null(vec_topics)
  ) {
    projects_data_sf <- projects_data_sf |>
      filter(
        if_any(
          contains(vec_topics),
          ~ .x == TRUE
        )
      )
  }

  if (
    !is.null(vec_pi_1)
  ) {
    projects_data_sf <- projects_data_sf |>
      filter(
        if_any(
          contains(vec_pi_1),
          ~ .x == TRUE
        )
      )
  }

  if (
    !is.null(vec_pi_2)
  ) {
    projects_data_sf <- projects_data_sf |>
      filter(
        if_any(
          contains(vec_pi_2),
          ~ .x == TRUE
        )
      )
  }

  if (
    !is.null(range_budget)
  ) {
    projects_data_sf <- projects_data_sf |>
      filter(
        total_budget |> between(
          min(range_budget),
          max(range_budget)
        )
      )
  }

  if (
    !is.null(range_self_funded_budget)
  ) {
    # Back to percentage scale
    range_self_funded_budget <- range_self_funded_budget / 100
    projects_data_sf <- projects_data_sf |>
      filter(
        prop_budget_orga |>
          between(
            min(range_self_funded_budget),
            max(range_self_funded_budget)
          )
      )
  }

  if (
    !is.null(cantons_main_org)
  ) {
    projects_data_sf <- projects_data_sf |>
      filter(
        id_canton %in% cantons_main_org
      )
  }

  return(projects_data_sf)
}
