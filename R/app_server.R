#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  # Store translation json as parsed list in session$userData
  # and not in reactiveValues because
  # - It will not change during session
  # - It need to be accessible everywhere
  session$userData$l_translation <- read_translation_json()

  r_global <- reactiveValues(
    zoom_level = NULL,
    # Set initial condition: no focus project is selected
    id_selected_project = NULL,
    language = NULL,
    projects_data_sf = NULL
  )

  observeEvent(
    input$screen_width,
    once = TRUE,
    {
      cli::cat_rule(
        sprintf("input$screen_width: %s", input$screen_width)
      )
      if (input$screen_width > 1000) {
        r_global$zoom_level <- 9
      } else {
        r_global$zoom_level <- 8
      }
    }
  )

  mod_map_server("map_1", r_global = r_global)

  mod_right_panel_server("right_panel_1", r_global = r_global)
}
