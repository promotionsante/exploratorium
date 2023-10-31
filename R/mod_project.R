#' project UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_project_ui <- function(id){
  ns <- NS(id)
  tagList(
    h1("observatoire")
  )
}

#' project Server Functions
#'
#' @noRd
mod_project_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_project_ui("project_1")

## To be copied in the server
# mod_project_server("project_1")
