#' Draw main interactive map
#'
#' @param projects_data_sf A sf data.frame containing coordinates of project
#' main organisation and project `short_title`.
#'
#' @param zoom_level An integer. The zoom level for the map. Defines
#' default zoom level.
#'
#' @return A leaflet object.
#'
#' @importFrom leaflet leaflet setView addProviderTiles leafletOptions setMaxBounds
#'
#' @noRd
draw_map_base <- function(zoom_level = 8) {
  switzerland_centroid <- get_switzerland_centroid()
  switzerland_bounding_box <- get_switzerland_bounding_box()

  leaflet(
    options = leafletOptions(minZoom = zoom_level)
  ) |>
    addProviderTiles(
      provider = "CartoDB.Positron"
    ) |>
    setView(
      lng = switzerland_centroid[["lng"]],
      lat = switzerland_centroid[["lat"]],
      zoom = zoom_level
    ) |>
    setMaxBounds(
      lng1 = switzerland_bounding_box[["xmin"]],
      lat1 = switzerland_bounding_box[["ymin"]],
      lng2 = switzerland_bounding_box[["xmax"]],
      lat2 = switzerland_bounding_box[["ymax"]]
    )
}
