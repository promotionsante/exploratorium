#' Draw the map focused on one project
#'
#' @param projects_data_sf A sf data.frame containing coordinates of project
#' main organisation and project `short_title`.
#' @param id_project Character. Id of the project.
#' @param zoom_level An integer. The zoom level for the map. Defines
#' default zoom level.
#'
#' @importFrom leaflet addCircleMarkers addPolygons addPolylines labelOptions
#' @importFrom dplyr filter
#'
#' @return A leaflet object.
#'
#' @export
draw_map_focus_one_project <- function(
  projects_data_sf,
  id_project,
  zoom_level = 8
) {
  # Extract the elements needed for the map
  ## The coordinates of the project
  ## The polygons of the canton with the info influenced/not influenced
  ## If appropriate, the lines between the projects and the cantons influenced
  geo_elements_influence <- get_influence_project(
    projects_data_sf = projects_data_sf,
    id_project = id_project
  )

  # Draw the map
  ## Add the cantons not influenced
  map_with_cantons_not_influenced <- draw_map_base(zoom_level) |>
    addPolygons(
      data = geo_elements_influence$cantons_sf_project |>
        filter(
          target_cantons == FALSE
        ),
      weight = 1,
      color = psch_blue(),
      fillColor = psch_blue(),
      fillOpacity = 0.2
    )

  ## Add the cantons influenced if appropriate and the lines between the project and them
  if (!is.null(geo_elements_influence$cantons_influenced_lines)) {
    # Print the cantons in orange
    map_with_cantons_influenced <- map_with_cantons_not_influenced |>
      addPolygons(
        data = geo_elements_influence$cantons_sf_project |>
          filter(
            target_cantons == TRUE
          ),
        weight = 2,
        color = psch_dark_orange(),
        fillColor = psch_orange(),
        fillOpacity = 0.5,
        label = ~ gsub("^CH\\.", "", as.character(HASC_1)),
        labelOptions = labelOptions(
          style = list("font-size" = "12px") # Adjust the font size here
        )
      )

    # Print the lines in orange
    map_geo_influence <- map_with_cantons_influenced |>
      addPolylines(
        data = geo_elements_influence$cantons_influenced_lines,
        color = psch_dark_orange(),
        weight = 2
      )
  } else {
    map_geo_influence <- map_with_cantons_not_influenced
  }

  map_project_and_geo_influence <- map_geo_influence |>
    addCircleMarkers(
      data = geo_elements_influence$coord_sf_project,
      color = psch_orange(),
      stroke = FALSE,
      fillOpacity = 0.8,
      label = ~ as.character(short_title)
    )

  class(map_project_and_geo_influence) <- c(
    class(map_project_and_geo_influence),
    "one-project"
  )

  return(map_project_and_geo_influence)
}
