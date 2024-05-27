#' Get the data of the distribution of the budget for one project
#'
#' @param id_project Character. ID of the project, 'short_title' in data.
#' @param data_projects Tibble. Data projects.
#' @param language Character. Language, 'fr' or 'de'.
#'
#' @importFrom dplyr filter select
#' @importFrom sf st_drop_geometry
#' @importFrom tibble tibble
#' @importFrom scales number
#'
#' @return Tibble. Data to be plotted.
#'
#' @noRd
#' @examples
#' data("toy_projects_data_sf")
#'
#' get_data_repart_budget_one_project(
#'   data_projects = toy_projects_data_sf,
#'   id_project = "1+1=3  PGV03.038",
#'   language = "de"
#' )
#'
#' get_data_repart_budget_one_project(
#'   data_projects = toy_projects_data_sf,
#'   id_project = "1+1=3  PGV03.038",
#'   language = "fr"
#' )
get_data_repart_budget_one_project <- function(
    id_project,
    data_projects,
    language = c("de", "fr")) {

  # Filter the project
  data_this_project <- data_projects |>
    filter(short_title == id_project) |>
    st_drop_geometry()

  # Create the data
  data_repart <- tibble(
    name = c("gfch", "orga", "third")
  )

  data_repart$value <- round(
    data_this_project |>
      select(
        "prop_budget_gfch",
        "prop_budget_orga",
        "prop_budget_third_party"
      ) |> unlist() * 100,
    1)

  data_repart$value_tooltip <- data_this_project |>
    select(
      "budget_gfch",
      "budget_orga",
      "budget_third_party"
    ) |> unlist() |>
    number(
      suffix = " CHF"
    )

  # Translate the data
  if (language == "de") {

    data_repart$name <- c(
      "GFCH",
      "Haupt-Org",
      "Dritte"
    )

  } else if (language == "fr") {

    data_repart$name <- c(
      "PSCH",
      "Organisation responsable",
      "Tiers"
    )

  }

  return(data_repart)

}
