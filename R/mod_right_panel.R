#' right_panel UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @importFrom shinyWidgets materialSwitch
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_right_panel_ui <- function(id){
  ns <- NS(id)
  tagList(

    div(
      languageSwitchInput(
        "language_switch",
        label = NULL,
        values = c("DE", "FR"),
        selected = "de"
      )
    ),

    uiOutput(
      outputId = ns("right_panel_to_render")
    )
  )
}

#' right_panel Server Functions
#'
#' @noRd
mod_right_panel_server <- function(id, r_global){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    r_local <- reactiveValues()

    # Set initial view: project selection
    observeEvent(
      TRUE,
      once = TRUE, {
        r_local$right_panel_to_render <- mod_projects_selection_ui(
          ns("projects_selection_1")
        )
      })

    observeEvent(
      r_global$id_selected_project,
      ignoreNULL = FALSE,
      {
        if (
          is.null(r_global$id_selected_project)
        ) {
          r_local$right_panel_to_render <- mod_projects_selection_ui(
            ns("projects_selection_1")
          )
        } else {
          r_local$right_panel_to_render <- mod_one_project_ui(
            ns("one_project_1")
          )
        }
      }
    )

    output$right_panel_to_render <- renderUI({
      r_local$right_panel_to_render
    })

    mod_projects_selection_server("projects_selection_1")
    mod_one_project_server("one_project_1", r_global = r_global)

  })
}

## To be copied in the UI
# mod_right_panel_ui("right_panel_1")

## To be copied in the server
# mod_right_panel_server("right_panel_1")
