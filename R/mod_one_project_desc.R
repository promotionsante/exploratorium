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
    actionButton(
      inputId = ns("back_to_project_selection_view"),
      label = "Back to project selection"
    ),
    htmlOutput(
      outputId = ns("project_card")
    )
  )
}

#' project Server Functions
#'
#' @importFrom glue glue
#'
#' @noRd
mod_one_project_desc_server <- function(id, r_global){
  moduleServer( id, function(input, output, session){

    ns <- session$ns

    observeEvent(
      input$back_to_project_selection_view,
      {
        r_global$id_selected_project <- NULL
        output$project_card <- NULL

      })

    add_resource_path(
      "projectscardslibrary",
      system.file(
        "data-projects-cards",
        package = "observatoire")
    )

    observeEvent(
      r_global$id_selected_project,
      {

        clean_id_project <- clean_id_project(
          id_project = r_global$id_selected_project
        )

        output$project_card <- renderUI({
          tags$iframe(
            seamless = "seamless",
            src = glue("projectscardslibrary/project_card_{clean_id_project}_de.html"),
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
