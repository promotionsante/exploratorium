#' Base function to get input values to be displayed
#'
#' @param language A character either "fr" or "de".
#' @param pattern A character. Pattern for column names to be
#' extracted from variable dic.
#'
#' @return A named vector
#'
#' @importFrom readr read_csv2
#' @noRd
get_input_data_to_display <- function(
  language,
  pattern
) {
  dic_variables <- suppressMessages(
    read_csv2(
      file = app_sys("data-dic/dic_variables.csv"),
      show_col_types = FALSE
    )
  )

  input_dic <- dic_variables[
    grep(pattern, dic_variables$id),
  ]

  inputs_to_diplay <- input_dic$id
  names(inputs_to_diplay) <- input_dic[[language]]

  return(inputs_to_diplay)
}
