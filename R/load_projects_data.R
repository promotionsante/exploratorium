#' Load projects data from disk
#'
#' @param language A characer. Either "fr" or "de"
#'
#' @return A sf data.frame
#'
#' @noRd
#' @examples
#' load_projects_data(
#'   language = "fr"
#' )
load_projects_data <- function(language) {
  stopifnot(
    "Unknown language provided" = language %in% c("fr", "de")
  )
  readRDS(
    file = app_sys(
      "data-projects",
      sprintf("projects_%s.rds", language)
    )
  )
}
