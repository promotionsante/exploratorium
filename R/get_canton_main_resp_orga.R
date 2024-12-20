#' Get the canton of the principale organization
#'
#' @param data Tibble. Raw data about projects, with the good columns names.
#' @param cantons_sf Sf data. Cantons geometry.
#'
#' @importFrom dplyr filter mutate select left_join rename distinct
#' @importFrom glue glue
#' @importFrom sf st_read st_intersects st_as_sf st_join
#' @importFrom purrr map_df
#' @importFrom tibble as_tibble tibble
#'
#'
#' @return A tibble with the name of the canton
#'
#' @noRd
get_canton_main_resp_orga <- function(
  data,
  cantons_sf = read_cantons_sf()
) {
  # Check if some GPS points are missing
  nb_missing_gps_points <- data |>
    filter(is.na(longitude) | is.na(latitude)) |>
    nrow()

  if (nb_missing_gps_points > 0) {
    message(
      glue(
        "{nb_missing_gps_points} project.s is.are not associated to a GPS point.",
        "Please correct the problem before restarting the data preparation workflow,",
        "or this.these project.s will not be displayed on the observatory map.",
        .sep = "\n"
      )
    )
  }

  data_with_coord <- data |>
    select(short_title, geometry)

  data_with_id_canton <- st_join(
    x = data_with_coord,
    y = select(cantons_sf, HASC_1)
  ) |>
    rename(
      id_canton = HASC_1
    )

  # Add the canton to the raw data
  data_with_canton <- st_join(
    x = data,
    y = data_with_id_canton,
    suffix = c("", "extra")
  ) |>
    select(-short_titleextra) |>
    distinct()

  # Check if all cantons have been found
  nb_canton_not_found <- data_with_canton |>
    filter(!is.na(longitude) & !is.na(latitude)) |>
    filter(is.na(id_canton)) |>
    nrow()

  if (nb_canton_not_found > 0) {
    stop(
      glue(
        "{nb_canton_not_found} project.s is.are not associated to a canton.",
        "Please correct the problem before restarting the data preparation workflow,",
        "or this.these project.s will not be displayed on the observatory map.",
        .sep = "\n"
      )
    )
  }

  return(data_with_canton)
}
