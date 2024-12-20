get_budget_range <- function(
  projects_data_sf) {
  range(
    projects_data_sf[["total_budget"]],
    na.rm = TRUE
  )
}
