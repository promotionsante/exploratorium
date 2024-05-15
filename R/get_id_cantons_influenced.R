#' Get the id of the cantons influenced
#'
#' @param data Tibble. Raw data about projects.
#' @param dic_cantons Tibble. Canton dictionary. Mainly used for examples and unit testing purpose.
#'
#' @importFrom tidyr separate_rows nest
#' @importFrom dplyr select pull distinct left_join group_by ungroup mutate
#' @importFrom glue glue glue_collapse
#' @importFrom sf st_drop_geometry
#' @importFrom readr read_csv
#'
#' @return A tibble with a column geo_range_id with te tid of the canton
#'
#' @noRd
#' @examples
#' # Load the toy datasets
#' data("toy_data_pgv")
#' data("toy_dic_cantons")
#' data("toy_dic_variables")
#'
#' toy_data <- toy_data_pgv |>
#'   add_col_raw_data(
#'     dic_variables = toy_dic_variables
#'   ) |>
#'   clean_raw_data()
#'
#' # Get the id of the cantons influenced
#' toy_data |>
#'   get_id_cantons_influenced(
#'     dic_cantons = toy_dic_cantons
#'   ) |>
#'   select(
#'     short_title,
#'     geo_range_id
#'   )
get_id_cantons_influenced <- function(
    data,
    dic_cantons = NULL
  ){

  # Import the variables dictionary saved in the package
  if (is.null(dic_cantons)) {
    dic_cantons <- read_csv(
      system.file(
        "data-dic",
        "dic_cantons.csv",
        package = "exploratorium"
      ),
      show_col_types = FALSE
    )
  }

  # Check if all cantons in data are present in the dictionary
  data_with_separate_cantons <- data |>
    mutate(
      geo_range = ifelse(
        is.na(geo_range),
        "Noch offen",
        geo_range
      )
    ) |>
    separate_rows(
      geo_range,
      sep = ",*\r\n"
  )

  cantons_in_data <- data_with_separate_cantons |>
    filter(!is.na(geo_range)) |>
    distinct(
      geo_range
    ) |>
    pull()

  cantons_in_dic <- dic_cantons |>
    select(
      de
    ) |>
    pull()

  check_all_cantons_in_dic <- cantons_in_data %in% cantons_in_dic
  names(check_all_cantons_in_dic) <- cantons_in_data

  if (isFALSE(all(check_all_cantons_in_dic))) {

    vec_cantons_absent <- glue_collapse(
      names(
        check_all_cantons_in_dic[check_all_cantons_in_dic == FALSE]
      ),
      sep = ", "
    )

    stop(
      glue(
        "Some cantons present in the Reichweite column of the raw data are not present",
        "in the dic_cantons.csv dictionary file",
        "Please check the following cantons before to try again to prepare the data",
        {vec_cantons_absent},
        .sep = "\n"
      )
    )
  }

  # Get the ID of the cantons
  data_with_separate_id_cantons <- left_join(
    data_with_separate_cantons,
    dic_cantons |>
      select(
        de,
        id
      ),
    by = c("geo_range" = "de")
  )

  # Sep the ID with ,
  data_with_id_cantons <- data_with_separate_id_cantons |>
    st_drop_geometry() |>
    select(short_title, id) |>
    group_by(
      short_title
    ) |>
    nest(
      geo_range_id = id
    ) |>
    mutate(
      geo_range_id = paste(
        unlist(
          geo_range_id
        ),
        collapse = ", "
      )
    ) |>
    ungroup()

  # Combine everything
  data_with_id_cantons <- left_join(
    data,
    data_with_id_cantons,
    by = "short_title"
  )

  return(
    data_with_id_cantons
  )

}
