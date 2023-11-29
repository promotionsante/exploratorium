#' one_project UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_one_project_ui <- function(id){
  ns <- NS(id)
  tagList(

    actionButton(
      inputId = ns("back_to_project_selection_view"),
      label = NULL,
      icon = NULL,
      width = "0%",
      class = "orange-arrow-button",
      get_back_arrow_html()
    ),

    mod_one_project_desc_ui(ns("project_1"))

  )
}

#' one_project Server Functions
#'
#' @noRd
mod_one_project_server <- function(id, r_global){

  moduleServer( id, function(input, output, session){
    ns <- session$ns

  observeEvent(
      input$back_to_project_selection_view,
      {
    r_global$id_selected_project <- NULL
    output$project_card <- NULL
  })

  observeEvent(
    r_global$click_map,
    {
      if (r_global$click_map == "click-on-map-in-project-view") {
        r_global$id_selected_project <- NULL
        output$project_card <- NULL
      }
    })

    mod_one_project_desc_server("project_1", r_global = r_global)

  })
}

## To be copied in the UI
# mod_one_project_ui("one_project_1")

## To be copied in the server
# mod_one_project_server("one_project_1")
