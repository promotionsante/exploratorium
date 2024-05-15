#' Get the number of cantons influenced
#'
#' @param data Tibble. Raw data about projects, with the good columns names.
#'
#' @importFrom dplyr mutate
#'
#' @return A tibble with a column with the number of cantons influenced
#'
#' @noRd
#' @examples
#' # Load the toy datasets
#' data("toy_data_pgv")
#' data("toy_dic_variables")
#'
#' raw_data <- toy_data_pgv |>
#'   add_col_raw_data(
#'     dic_variables = toy_dic_variables
#'   ) |>
#'   clean_raw_data()
#'
#' # Get the number of cantons influenced
#' raw_data |>
#'   get_nb_cantons_influenced() |>
#'   select(geo_range, nb_cantons_influenced)
get_nb_cantons_influenced <- function(
    data
    ){

  data |>
    mutate(
      nb_cantons_influenced = lengths(gregexpr(
          ",",
          geo_range
        )
    ) + 1)

}
