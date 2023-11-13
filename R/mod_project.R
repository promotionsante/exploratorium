#' project UI Function
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
mod_project_ui <- function(id){
  ns <- NS(id)

  tagList(

    materialSwitch(
      inputId = ns("language")
    ),

    htmlOutput(ns("projectcard"))

  )
}

#' project Server Functions
#'
#' @noRd
mod_project_server <- function(id){
  moduleServer( id, function(input, output, session){

    ns <- session$ns

    observeEvent(input$language,
                 ignoreNULL = TRUE,
                 ignoreInit = TRUE, {

      add_resource_path(
        "projectscardslibrary",
        system.file(
          "data-projects-cards",
          package = "observatoire")
      )

      output$projectcard <- renderUI({

        tags$iframe(
          seamless = "seamless",
          src = "projectscardslibrary/template_projects_cards.html",
          frameborder = "0",
          style = "width:100vw;height:100vh;"
        )

      })
    })

  })
}

## To be copied in the UI
# mod_project_ui("project_1")

## To be copied in the server
# mod_project_server("project_1")
