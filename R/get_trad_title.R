#' Get the translation of a title
#'
#' @param title_id Character. Id of the title in the dictionary.
#' @param language Character. Language ("de" or "fr").
#' @param dic_titles_pages Tibble. Title of the pages dictionaries. Mainly used for examples and unit testing purpose.
#'
#' @importFrom readr read_csv2 locale
#' @importFrom dplyr filter pull
#'
#' @return A character. Translation.
#'
#' @noRd
#' @examples
#' data("toy_dic_titles_pages")
#'
#' get_trad_title(
#'   title_id = "project_start_year_title",
#'   language = "fr",
#'   dic_titles_pages = toy_dic_titles_pages
#' )
#'
#' get_trad_title(
#'   title_id = "project_start_year_title",
#'   language = "de",
#'   dic_titles_pages = toy_dic_titles_pages
#' )
get_trad_title <- function(
    title_id,
    language,
    dic_titles_pages = NULL
    ) {

  if (is.null(dic_titles_pages)) {
    dic_titles_pages <- read_csv2(
      app_sys("data-dic",
              "dic_titles_app.csv"),
      show_col_types = FALSE,
      locale = locale(decimal_mark = ",", grouping_mark = ".")
    )
  }

  dic_titles_pages |>
    filter(id == title_id) |>
    pull(language)

}
