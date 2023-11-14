#' project UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_one_project_desc_ui <- function(id){
  ns <- NS(id)

  tagList(
    htmlOutput(ns("projectcard"))
  )
}

#' project Server Functions
#'
#' @importFrom glue glue
#'
#' @noRd
mod_one_project_desc_server <- function(id){
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
          src = glue("projectscardslibrary/template_projects_cards_de.html"),
          frameborder = "0",
          style = "width:100vw;height:100vh;"
        )

      })
    })

  })
}

## To be copied in the UI
# mod_one_project_desc_ui("project_1")

## To be copied in the server
# mod_one_project_desc_server("project_1")
