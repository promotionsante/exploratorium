#' Add the proper colums names to the projects data
#'
#' @param data Tibble. Raw data about projects.
#' @param dic_variables Tibble. Variables dictionaries. Mainly used for examples and unit testing purpose.
#'
#' @importFrom readr read_csv2
#'
#' @return The raw data about the projects with the good columns names.
#'
#' @noRd
#' @examples
#' # Load the toy datasets
#' data("toy_data_pgv")
#' data("toy_dic_variables")
#'
#' # Add the good columns names
#' toy_data_pgv |>
#'   add_col_raw_data(
#'     dic_variables = toy_dic_variables
#'   )
add_col_raw_data <- function(
    data,
    dic_variables = NULL
){

  # Import the variables dictionary saved in the package
  if (is.null(dic_variables)) {
    dic_variables <- read_csv2(
      system.file(
        "data-dic",
        "dic_variables.csv",
        package = "exploratorium"
      ),
      show_col_types = FALSE
    )
  }

  # Check if all columns are present
  all_expected_columns_are_present <- all(sort(colnames(data)) == sort(dic_variables$name_col_in_raw_data))
  if (isFALSE(all_expected_columns_are_present)) {
    stop(
      paste(
        "The columns in the raw projects data file are not the expected ones.",
        "Please, make sure that the columns are those described in the file dic_variables.csv.",
        sep = "\n"
      )
    )
  }

  # Replace german column names with the names of the variables
  colnames(data) <- dic_variables$name_variable[
    match(
      dic_variables$name_col_in_raw_data,
      names(data)
    )
  ]

  return(data)

}
