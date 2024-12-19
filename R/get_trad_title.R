#' Get the translation of a title
#'
#' @param title_id Character. Id of the title in the dictionary.
#' @param language Character. Language ("de" or "fr").
#'
#' @importFrom readr read_csv2 locale
#' @importFrom dplyr filter pull
#'
#' @return A character. Translation.
#'
#' @noRd
get_trad_title <- function(
  title_id,
  language
) {
  dic_titles_pages <- read_csv2(
    app_sys(
      "data-dic",
      "dic_titles_app.csv"
    ),
    show_col_types = FALSE,
    locale = locale(decimal_mark = ",", grouping_mark = ".")
  )

  dic_titles_pages |>
    filter(id == title_id) |>
    pull(language)
}
