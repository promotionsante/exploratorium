#' Consolidate topic data
#'
#' Make sure information between `topic` character column and
#' the binary `topic_` columns is identical
#'
#' @param data Tibble. Raw data about projects, with the good columns names.
#' @param dic_variables Tibble. Variables dictionaries. Mainly used for examples and unit testing purpose.
#'
#' @return A tibble.
#'
#' @importFrom dplyr select full_join inner_join mutate starts_with
#' @importFrom tidyr separate_rows complete pivot_wider
#' @noRd
#' @examples
#' # Load the toy datasets
#' data("toy_data_pgv")
#' data("toy_dic_variables")
#' data("toy_cantons_sf")
#'
#' toy_data_pgv |>
#'   add_col_raw_data(
#'     dic_variables = toy_dic_variables
#'   ) |>
#'   clean_raw_data() |>
#'   consolidate_topic_data()
consolidate_topic_data <- function(
    data,
    dic_variables = NULL
) {

  if (is.null(dic_variables)) {
    dic_variables <- suppressMessages(
      read_csv2(
        system.file(
          "data-dic",
          "dic_variables.csv",
          package = "exploratorium"
          ),
        show_col_types = FALSE
      )
    )
  }

  dic_variables_topic_de <- dic_variables |>
    select(name_col_in_raw_data, name_variable) |>
    filter(
      grepl(
        "^topic_",
        name_variable
      )
    )

  # Get one row per topic
  data_separated_by_topic <- data |>
    select(
      short_title,
      topic
    ) |>
    separate_rows(
      topic,
      sep = ",*\r\n|, "
    ) |>
    mutate(
      topic = gsub("\\W$", "", topic)
    )


  # Get topic names in English
  data_topic_in_english <- data_separated_by_topic |>
    full_join(
      dic_variables_topic_de,
      by = c("topic" = "name_col_in_raw_data")
    ) |>
    select(-topic)

  # Generate new binary topic columns
  data_topic_consolidated <- data_topic_in_english |>
    mutate(
      # Add flag value for projects without any topics
      name_variable = ifelse(
        is.na(name_variable),
        "none",
        name_variable
      ),
      topic_value = TRUE
    ) |>
    complete(
      short_title,
      name_variable,
      fill = list(
        topic_value = FALSE
      )
    ) |>
    pivot_wider(
      names_from = name_variable,
      values_from = topic_value
    ) |>
    filter(
      # Remove project artifacts: categories without associated projetcs
      !is.na(short_title)
    ) |>
    # Remove flag variable
    select(-none)

  data_with_consolidated_topic_columns <- data |>
    # Remove existing topic_ columns
    select(
      -starts_with("topic_")
    ) |>
    # Add consolidated topic_ columns back to main dataset
    inner_join(
      data_topic_consolidated,
      by = "short_title"
    )

  return(data_with_consolidated_topic_columns)
}

