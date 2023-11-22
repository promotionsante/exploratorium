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

    uiOutput(
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
      c(
        r_global$id_selected_project,
        r_global$language
      ),
      {

        clean_id_project <- clean_id_project(
          id_project = r_global$id_selected_project
        )

        language <- r_global$language

        output$project_card <- renderUI({
          includeHTML(
            system.file(
              "data-projects-cards",
              glue("project_card_{clean_id_project}_{language}.html"),
              package = "observatoire"
            )
          )
        })

      })

  })

}

## To be copied in the UI
# mod_one_project_desc_ui("project_1")

## To be copied in the server
# mod_one_project_desc_server("project_1")
