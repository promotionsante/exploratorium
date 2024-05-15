#' Get unique topics to display
#'
#' and put "other" topics at the end.
#'
#' @inheritParams get_input_data_to_display
#'
#' @return A named character vector ending with "Other" (andere/autre) topics.
#' Names correspond to FR or DE translation displayed to the user.
#'
#'
#' @noRd
#' @examples
#' get_topics_to_display(
#'   language = "fr"
#' )
get_topics_to_display <- function(language) {
  get_input_data_to_display(
    language = language,
    pattern = "^topic_"
  )
}
