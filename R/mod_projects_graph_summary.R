#' projects_graph_summary UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_projects_graph_summary_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' projects_graph_summary Server Functions
#'
#' @noRd 
mod_projects_graph_summary_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_projects_graph_summary_ui("projects_graph_summary_1")
    
## To be copied in the server
# mod_projects_graph_summary_server("projects_graph_summary_1")
