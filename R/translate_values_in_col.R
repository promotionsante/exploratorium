#' Translate the value of a given column with
#'
#' @param data Tibble. Data to be translated.
#' @param col_to_translate Character. Column to be translated.
#' @param language Character. Language. Should be "fr" or "de".
#' @param dictionary name of the dictionary to use. One of the dic_*.csv files
#' present in inst/data-dic.
#'
#' @importFrom readr read_delim
#' @importFrom dplyr left_join select
#'
#' @return Data with the column translated.
#'
#' @noRd
translate_values_in_col <- function(
    data,
    col_to_translate,
    language = c("de", "fr"),
    dictionary = "dic_values.csv"
    ){

  language <- match.arg(language)

  # Check if the column is present
  is_col_in_data <- col_to_translate %in% colnames(data)

  if (isFALSE(is_col_in_data)) {
    stop(
      glue("The column {col_to_translate} is not present in the data")
    )
  }

  ## Import the values dictionary saved in the package
  # use read_delim to have more control and avoid default value verbose
  # message of read_csv2
    dic_values <- read_delim(
      file = system.file(
        "data-dic",
        dictionary,
        package = "exploratorium"
      ),
      delim = ";",
      escape_double = FALSE,
      trim_ws = TRUE,
      show_col_types = FALSE
    )

    join_by <- "id"
    names(join_by) <- col_to_translate
    ## Translate the column
    # Get translated values in corresponding language i.e.
    # we would have both
    # fr = c("Termin\u00e9", "En cours")
    # status = c("FINISHED", "IMPLEMENTATION")
    data_translated <- left_join(
      data,
      dic_values[c("id", language)],
      by = join_by
    )
    # Remove old untranslated column
    # .i.e status = c("FINISHED", "IMPLEMENTATION")
    data_translated[[col_to_translate]] <- NULL
    # Replace translated column name with column original name
    # .i.e fr -> status
    names(data_translated) <- sub(
      pattern = sprintf("^%s$", language),
      replacement = col_to_translate,
      x = names(data_translated)
    )

  return(data_translated)

}
