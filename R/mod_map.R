#' map UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom leaflet leafletOutput
#' @importFrom shiny NS tagList
mod_map_ui <- function(id){
  ns <- NS(id)
  tagList(
    div(
      class = "ch-map",
      leafletOutput(
        outputId = ns("map"),
        width = "100%",
        height = "100%"
      )
    )
  )
}

#' map Server Functions
#'
#' @importFrom leaflet renderLeaflet
#' @noRd
mod_map_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$map <- renderLeaflet({
      draw_map_selected_projects(
        projects_data_sf = dummy_project_data_sf()
      )
    })
  })
}

## To be copied in the UI
# mod_map_ui("map_1")

## To be copied in the server
# mod_map_server("map_1")
