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
        ns("language_switch"),
        label = NULL,
        values = c("DE", "FR"),
        selected = "de"
      )
    ),
    div(
      mod_projects_selection_ui(
        ns("projects_selection_1")
      ),
      id = "project_selection_panel",
    ) ,
      mod_one_project_ui(
        ns("one_project_1")
      )
  )
}

#' right_panel Server Functions
#'
#' @importFrom golem invoke_js
#'
#' @noRd
mod_right_panel_server <- function(id, r_global){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    r_local <- reactiveValues()

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
        r_global$language <- language
        r_global$projects_data_sf <- load_projects_data(
          language = language
        )
      })

    observeEvent(
      r_global$id_selected_project,
      ignoreNULL = FALSE,
      priority = -1,
      {
        if (
          is.null(r_global$id_selected_project)
        ) {
          invoke_js(
            fun = "showid",
            "project_selection_panel"
          )
        } else {
          invoke_js(
            fun = "hideid",
            "project_selection_panel"
          )
        }
      }
    )

    mod_projects_selection_server("projects_selection_1", r_global = r_global)
    mod_one_project_server("one_project_1", r_global = r_global)

  })
}

## To be copied in the UI
# mod_right_panel_ui("right_panel_1")

## To be copied in the server
# mod_right_panel_server("right_panel_1")
