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

    mod_one_project_desc_ui(ns("project_1"))

  )
}

#' one_project Server Functions
#'
#' @noRd
mod_one_project_server <- function(id, r_global){

  moduleServer( id, function(input, output, session){
    ns <- session$ns

    mod_one_project_desc_server("project_1", r_global = r_global)

  })
}

## To be copied in the UI
# mod_one_project_ui("one_project_1")

## To be copied in the server
# mod_one_project_server("one_project_1")
