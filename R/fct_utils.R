#'
#' @noRd
psch_blue <- function() {
  # Meerblau
  "#578397"
}

#'
#' @noRd
psch_dark_orange <- function() {
  # Corporate: Orange
  "#E06900"
}

#'
#' @noRd
psch_orange <- function() {
  # Corporate: Orange
  "#f59300"
}

#'
#' @noRd
psch_yellow <- function() {
  # BGM: Gelb
  "#fbbc00"
}

#'
#' @noRd
psch_bronce <- function() {
  # Bronce
  "#695b2e"
}

#'
#' @noRd
psch_green <- function() {
  # Lindengrün
  "#b1c000"
}

#' Read cantons polygons data
#' @importFrom sf st_read
#'
#' @noRd
read_cantons_sf <- function() {
  st_read(
    dsn = system.file(
      "data-geo",
      "gadm41_CHE_1.json",
      package = "exploratorium"
    ),
    quiet = TRUE
  )
}

#' Read projects data
#' @importFrom glue glue
#'
#' @noRd
read_projects_data <- function(
  language = c("de", "fr")) {
  language <- match.arg(language)

  readRDS(
    system.file(
      "data-projects",
      glue("projects_{language}.rds"),
      package = "exploratorium"
    )
  )
}
