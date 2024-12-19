#' Translate the data (values in the table) in FR and DE
#'
#' @param data Tibble. Raw data about projects, with the good columns names.
#' @param cols_to_translate Character. Columns to be translated.
#'
#' @importFrom readr read_csv2
#'
#' @return A list of 2 tibbles (FR and DE), with mandatory columns translated.
#'
#' @noRd
translate_values_in_data <- function(
  data,
  cols_to_translate
) {
  # Import the values dictionary saved in the package
  dic_values <- read_csv2(
    system.file(
      "data-dic",
      "dic_values.csv",
      package = "exploratorium"
    ),
    show_col_types = FALSE
  )

  # Translate the data in DE
  for (i in 1:length(cols_to_translate)) {
    data_de <- translate_values_in_col(
      data = data,
      col_to_translate = cols_to_translate[i],
      language = "de"
    )
  }

  # Translate the data in FR
  for (i in 1:length(cols_to_translate)) {
    data_fr <- translate_values_in_col(
      data = data,
      col_to_translate = cols_to_translate[i],
      language = "fr"
    )
  }

  list(
    data_fr = data_fr,
    data_de = data_de
  )
}
