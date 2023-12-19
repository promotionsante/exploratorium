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

    r_local <- reactiveValues()

    # Set initial view: project selection
    observeEvent(
      r_global$zoom_level,
      once = TRUE, {
        req(r_global$zoom_level)
        r_local$map_to_draw <- draw_map_selected_projects(
          projects_data_sf = r_global$selected_projects_sf,
          zoom_level = r_global$zoom_level
        )
      })

    # Draw appropriate map
    observeEvent(
      c(
        r_global$id_selected_project,
        r_global$selected_projects_sf,
        r_global$language
      ),
      ignoreInit = TRUE,
      ignoreNULL = FALSE,
      {
        if (
          is.null(r_global$id_selected_project)
        ) {
          r_local$map_to_draw <- draw_map_selected_projects(
            projects_data_sf = r_global$selected_projects_sf,
            zoom_level = r_global$zoom_level,
            language = r_global$language
          )
        } else {
          r_local$map_to_draw <- draw_map_focus_one_project(
            projects_data_sf = r_global$selected_projects_sf,
            id_project = r_global$id_selected_project,
            zoom_level = r_global$zoom_level
          )
        }
      }
    )

    output$map <- renderLeaflet({
      r_local$map_to_draw
    })

    # Detect click on map
    observeEvent(
      input$map_click, {

        if (
          inherits(r_local$map_to_draw, "all-projects")
        ) {
          r_global$click_map <- "click-on-map-in-general-view"
        }

        if (
          inherits(r_local$map_to_draw, "one-project")
        ) {
          r_global$click_map <- "click-on-map-in-project-view"
        }

      })

    # Detect project selection
    observeEvent(
      input$map_marker_click$id,
      ignoreNULL = TRUE,
      ignoreInit = TRUE, {

        print(
          paste("Project selected:", input$map_marker_click$id)
        )
        r_global$id_selected_project <- input$map_marker_click$id

      })

  })
}

## To be copied in the UI
# mod_map_ui("map_1")

## To be copied in the server
# mod_map_server("map_1")
