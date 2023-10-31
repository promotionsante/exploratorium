#' Draw main interactive map
#'
#' @return A leaflet object.
#'
#' @importFrom leaflet leaflet setView addTiles  addMarkers addProviderTiles
#' @noRd
draw_leaflet_map <- function() {

  # Dummy data for prototyping only
  dummy_sf <- data.frame(
    name = "PSCH",
    addr = "52 Avenue de la Gare, 1003 Lausanne, Switzerland",
    lat = 46.51756965,
    long = 6.63061493418584
  ) |>
    sf::st_as_sf(
      coords = c("long", "lat"),
      crs = 4326
    )

  leaflet(
    data = dummy_sf
  ) |>
    addTiles() |>
    addMarkers() |>
    addProviderTiles(
      provider = "CartoDB.Positron"
      ) |>
    setView(
      lng = 6.63061493418584,
      lat = 46.51756965,
      zoom = 8
    )
}


