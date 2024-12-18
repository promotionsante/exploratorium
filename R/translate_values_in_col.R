#' Translate the value of a given column with
#'
#' @param data Tibble. Data to be translated.
#' @param col_to_translate Character. Column to be translated.
#' @param language Character. Language. Should be "fr" or "de".
#'
#' @importFrom readr read_csv2
#' @importFrom dplyr left_join select
#'
#' @return Data with the column translated.
#'
#' @noRd
translate_values_in_col <- function(
    data,
    col_to_translate,
    language = c("de", "fr")
    ){

  language <- match.arg(language)

  # Check if the column is present
  is_col_in_data <- col_to_translate %in% colnames(data)

  if (isFALSE(is_col_in_data)) {
    stop(
      glue("The column {col_to_translate} is not present in the data")
    )
  }

  # Import the values dictionary saved in the package
    dic_values <- read_csv2(
      system.file(
        "data-dic",
        "dic_values.csv",
        package = "exploratorium"
      ),
      show_col_types = FALSE
    )

    # Translate the column
    data_translated <- left_join(
      data,
      dic_values[c("value", language)],
      by = c("status"  = "value")
    ) |>
      select(
        -status,
        status = {{language}}
      )

  return(data_translated)

}
