#' @noRd
#' @examples
#' load_projects_data("fr") |>
#' get_cantons_main_org()
get_cantons_main_org <- function(
    projects_data_sf
) {
  cantons_main_org <- unique(projects_data_sf[["id_canton"]])
  names(cantons_main_org) <- gsub(
    pattern = "^CH\\.",
    replacement = "",
    cantons_main_org
  )
  return(cantons_main_org)
}
