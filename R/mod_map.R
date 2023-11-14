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
mod_map_server <- function(id, r_global){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    data("toy_projects_data_sf")
    output$map <- renderLeaflet({
      draw_map_selected_projects(
        projects_data_sf = toy_projects_data_sf,
        zoom_level = r_global$zoom_level
      )
    })

    # data("toy_projects_data_sf")
    # output$map <- renderLeaflet({
    #   draw_map_focus_one_project(
    #     projects_data_sf = toy_projects_data_sf,
    #     project_short_title = "1+1=3  PGV03.038"
    #   )
    # })

    observeEvent(
      input$map_marker_click$id,
      ignoreNULL = TRUE,
      ignoreInit = TRUE, {

      print(
        paste("Project selected:", input$map_marker_click$id)
      )

    })

  })
}

## To be copied in the UI
# mod_map_ui("map_1")

## To be copied in the server
# mod_map_server("map_1")
