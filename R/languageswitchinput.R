#' Create a custom toggl switch for the language
#'
#' @param inputId Character. InputId
#' @param label Character. label
#' @param values Character. values
#' @param selected Character. selected
#'
#' @return A shiny input
#'
#' @noRd
languageSwitchInput <- function(inputId, label, values, selected) {
  tags$div(
    id = inputId,
    class = "switch-container",
    tags$span(class = "switch-label", label),
    tags$span(class = "switch-label", values[1]),
    tags$label(
      class = "switch",
      tags$input(type = "checkbox", id = inputId, value = selected),
      tags$span(class = "slider")
    ),
    tags$span(class = "switch-label", values[2])
  )

}
