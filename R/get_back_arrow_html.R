#' Reads file containing back arrow svg
#'
#' Back arrow svg is stored in an html file in inst/
#'
#' @return A HTML element
#'
#' @noRd
#' @examples
#' get_back_arrow_html()
get_back_arrow_html <- function(){
  app_sys("back_arrow_svg.html") |>
    readLines() |>
    paste(collapse = "\n") |>
    HTML()
}
