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
    mod_projects_selection_ui(ns("projects_selection_1"))
  )
}

#' right_panel Server Functions
#'
#' @noRd
mod_right_panel_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    mod_projects_selection_server("projects_selection_1")
  })
}

## To be copied in the UI
# mod_right_panel_ui("right_panel_1")

## To be copied in the server
# mod_right_panel_server("right_panel_1")
