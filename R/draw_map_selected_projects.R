#' Draw map of selected projects
#'
#' @param projects_data_sf A sf data.frame containing coordinates of project
#' main organisation and project `short_title`.
#'
#' @param zoom_level An integer. The zoom level for the map. Defines
#' default zoom level.
#'
#' @param language A character string. App language "fr", "de"...
#'
#' @return A leaflet object.
#'
#' @importFrom leaflet addCircleMarkers addPolygons markerClusterOptions
#' @importFrom leaflet addLabelOnlyMarkers labelOptions
#'
#' @export
draw_map_selected_projects <- function(
  projects_data_sf,
  zoom_level = 8,
  language
) {
  base_map <- draw_map_base(zoom_level)

  empty_data <- nrow(projects_data_sf) == 0
  if (
    empty_data
  ) {
    ch_centroid <- get_switzerland_centroid()
    final_map <- base_map |>
      addLabelOnlyMarkers(
        lng = ch_centroid[["lng"]],
        lat = ch_centroid[["lat"]],
        label = translate_entry_server_side(
          language = language,
          key = "no_target_projects"
        ),
        labelOptions = labelOptions(
          noHide = TRUE,
          textsize = "20px",
          direction = "center"
        )
      )
  } else {
    final_map <- base_map |>
      addPolygons(
        data = read_cantons_sf(),
        weight = 1,
        color = psch_blue(),
        fillColor = psch_blue(),
        fillOpacity = 0.2
      ) |>
      addCircleMarkers(
        data = projects_data_sf,
        color = psch_orange(),
        stroke = FALSE,
        fillOpacity = 0.8,
        layerId = ~short_title,
        label = ~ as.character(short_title),
        clusterOptions = markerClusterOptions(
          showCoverageOnHover = FALSE,
          zoomToBoundsOnClick = FALSE,
          spiderLegPolylineOptions = list(
            weight = 1.5,
            color = psch_orange(),
            opacity = 0.5
          ),
          freezeAtZoom = zoom_level,
          spiderfyDistanceMultiplier = 1.5
        ),
        labelOptions = labelOptions(
          style = list(
            fontSize = "13px"
          )
        )
      )
  }

  class(final_map) <- c(
    class(final_map),
    "all-projects"
  )

  return(final_map)
}
