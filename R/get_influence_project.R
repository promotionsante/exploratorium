#' Get the geo influence elements of a project
#'
#' @param projects_data_sf A sf data.frame containing coordinates of project
#' main organisation and project `short_title`.
#' @param id_project Character. Id of the project.
#' @param cantons_sf Sf data. Cantons geometry. Mainly used for examples and unit testing purpose.
#'
#' @importFrom dplyr filter select left_join mutate rename
#' @importFrom sf st_drop_geometry st_centroid st_union st_cast st_agr<-
#' @importFrom tidyr separate_rows
#'
#' @return A list with 3 elements. The coord of the projetc, the polygons of the cantons and the info influenced/not influenced, the lines between the point anf the center of gravity of the cantons influenced.
#'
#' @noRd
#' @examples
#' data("toy_projects_data_sf")
#' data("toy_cantons_sf")
#'
#' get_influence_project(
#'   projects_data_sf = toy_projects_data_sf,
#'   id_project = "1+1=3  PGV03.038",
#'   cantons_sf = toy_cantons_sf
#' )
get_influence_project <- function(
  projects_data_sf,
  id_project,
  cantons_sf = NULL
) {
  dic_cantons_by_project <- read_csv_in_inst(
    "data-projects/dic_cantons_by_project.csv"
  )

  # Create a coord_sf_project object
  projects_data_sf_filtered <- projects_data_sf |>
    filter(short_title == id_project)

  coord_sf_project <- projects_data_sf_filtered |>
    select(short_title, geometry)

  # Extract target cantons from project_data_sf
  project_data_cantons_sf <- dic_cantons_by_project |>
    filter(short_title == id_project)

  # Create a cantons_sf_project object with column target_cantons (TRUE/FALSE)
  cantons_sf_project <- left_join(
    x = cantons_sf |>
      select(HASC_1, NAME_1, geometry),
    y = project_data_cantons_sf,
    by = c("HASC_1" = "geo_range_id")
  ) |>
    mutate(
      target_cantons = ifelse(
        is.na(short_title),
        FALSE,
        TRUE
      )
    ) |>
    select(-short_title)

  # Add the lines from the centroid
  if (nrow(cantons_sf_project |>
    filter(target_cantons == TRUE)) > 0) {
    st_agr(cantons_sf_project) <- "constant"

    cantons_centroid <- cantons_sf_project |>
      filter(
        target_cantons == TRUE
      ) |>
      st_centroid() |>
      mutate(
        project = coord_sf_project$geometry
      )

    cantons_influenced_lines <- st_union(
      cantons_centroid$geometry,
      cantons_centroid$project
    ) |>
      st_cast("LINESTRING")
  } else {
    cantons_influenced_lines <- NULL
  }

  return(
    list(
      coord_sf_project = coord_sf_project,
      cantons_sf_project = cantons_sf_project,
      cantons_influenced_lines = cantons_influenced_lines
    )
  )
}
