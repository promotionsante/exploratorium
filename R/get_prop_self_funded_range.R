#' @noRd
#' @examples
#' load_projects_data("fr") |>
#'   get_prop_self_funded_range()
get_prop_self_funded_range <- function(
    projects_data_sf
){
  prop_self_funded_range <- range(
    projects_data_sf[["prop_budget_orga"]],
    na.rm = TRUE
  ) |>
    round(
      digits = 2
    )
  prop_self_funded_range * 100
}
