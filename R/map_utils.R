#' @importFrom sf st_union st_centroid st_geometry
#' @importFrom stats setNames
#' @noRd
compute_switzerland_centroid <- function() {
  read_cantons_sf() |>
    st_union() |>
    st_centroid() |>
    st_geometry() |>
    unlist() |>
    setNames(
      c("lng", "lat")
    )
}

#'
#' @importFrom sf st_bbox
#' @noRd
compute_switzerland_bounding_box <- function() {
  bounding_box <- read_cantons_sf() |>
    st_bbox()
  attr(bounding_box, "crs") <- NULL
  attr(bounding_box, "class") <- NULL
  return(bounding_box)
}

#'
#' @noRd
get_switzerland_centroid <- function() {
  # Generated via compute_switzerland_centroid() |> dput()
  c(
    lng = 8.22730129708567,
    lat = 46.8019720665898
  )
}

#'
#' @noRd
get_switzerland_bounding_box <- function() {
  # Generated via compute_switzerland_bounding_box() |> dput()
  c(
    xmin = 5.9561,
    ymin = 45.8171,
    xmax = 10.4948,
    ymax = 47.8085
  )
}

#' Generate dummy project data
#' @return A sf data.frame
#' @importFrom sf st_as_sf
#'
#' @noRd
dummy_project_data_sf <- function() {
  data.frame(
    short_title = "PSCH",
    addr = "52 Avenue de la Gare, 1003 Lausanne, Switzerland",
    lat = 46.51756965,
    long = 6.63061493418584
  ) |>
    st_as_sf(
      coords = c("long", "lat"),
      crs = 4326
    )
}
