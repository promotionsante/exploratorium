#' Get the coordinates of the principale organization
#'
#' @param data Tibble. Raw data about projects, with the good columns names.
#' @param cantons_sf Sf data. Cantons geometry. Mainly used for examples and unit testing purpose.
#'
#' @importFrom tidygeocoder geocode
#' @importFrom dplyr mutate select filter
#' @importFrom glue glue
#' @importFrom sf st_read st_contains st_point st_union st_as_sf
#' @importFrom purrr map_lgl
#'
#' @return A tibble with a column with the coordinates of the principale organization.
#'
#' @noRd
#' @examples
#' # Load the toy datasets
#' data("toy_data_pgv")
#' data("toy_dic_variables")
#' data("toy_cantons_sf")
#'
#' toy_data <- toy_data_pgv |>
#'   add_col_raw_data(
#'     dic_variables = toy_dic_variables
#'   ) |>
#'   clean_raw_data()
#'
#' # Geocode the principale organisation of the project
#' toy_data |>
#'   get_coord_main_resp_orga(
#'     cantons_sf = toy_cantons_sf
#'   )
get_coord_main_resp_orga <- function(
  data,
  cantons_sf = NULL
) {
  # Check if some cities are missing
  nb_missing_cities <- data |>
    filter(is.na(city_code_main_resp_orga)) |>
    nrow()

  if (nb_missing_cities > 0) {
    message(
      glue(
        "{nb_missing_cities} project.s is.are not associated to a city.",
        "Please correct the problem before restarting the data preparation workflow,",
        "or this.these project.s will not be displayed on the observatory map.",
        .sep = "\n"
      )
    )
  }

  # Get the GPS coordinates
  data_with_long_lat <- data |>
    mutate(
      country = "Switzerland"
    ) |>
    geocode(
      city = city_code_main_resp_orga,
      postalcode = zip_code_main_resp_orga,
      country = country,
      method = "osm",
      lat = latitude,
      long = longitude
    ) |>
    select(-country)

  # Create sf points
  data_with_coord <- data_with_long_lat |>
    st_as_sf(
      coords = c("longitude", "latitude"),
      crs = 4326,
      remove = FALSE,
      na.fail = FALSE
    )

  # Check if the points are in Switzerland
  if (is.null(cantons_sf)) {
    cantons_sf <- read_cantons_sf()
  }

  switzerland_sf <- st_union(
    x = cantons_sf
  )

  check_is_in_switzerland <- data_with_coord |>
    filter(!is.na(longitude) & !is.na(latitude)) |>
    st_contains(
      x = switzerland_sf,
      y = _,
      sparse = FALSE
    ) |>
    as.logical()


  if (any(isFALSE(check_is_in_switzerland))) {
    stop(
      paste(
        "There is an issue in the geocoding of the principale organisation.",
        "Some points that have been found are not in Switzerland.",
        sep = "\n"
      )
    )
  }

  return(data_with_coord)
}

memoised_get_coord_main_resp_orga <- memoise::memoise(get_coord_main_resp_orga)
