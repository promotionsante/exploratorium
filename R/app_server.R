#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  r_global <- reactiveValues(
    zoom_level = 8
  )

  observeEvent(
    input$language_switch, {
      language <- if (
        isTRUE(input$language_switch)
      ) {
        "fr"
      } else {
        "de"
      }
      change_language(language)
      localize("html")
    })

  observeEvent(
    input$screen_width,
    once = TRUE,
    {
      cli::cat_rule(
        sprintf("input$screen_width: %s", input$screen_width)
      )
      if( input$screen_width > 1000) {
        r_global$zoom_level <- 9
      } else {
        r_global$zoom_level <- 8
      }
    })

  mod_map_server("map_1", r_global = r_global)
  mod_right_panel_server("right_panel_1")
  # mod_one_project_server("one_project_1")

}
