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
      width = "15%",
      class = "orange-arrow-button",
      HTML(
        '<svg xmlns="http://www.w3.org/2000/svg" width="15" height="13" viewBox="0 0 15 13" fill="none">
<path d="M8.48144 12.04L7.83105 12.6904C7.55566 12.9658 7.11035 12.9658 6.83789 12.6904L1.14258 6.99805C0.867188 6.72266 0.867188 6.27734 1.14258 6.00488L6.83789 0.30957C7.11328 0.0341797 7.55859 0.0341797 7.83105 0.30957L8.48144 0.959961C8.75977 1.23828 8.75391 1.69238 8.46973 1.96484L4.93945 5.32813H13.3594C13.749 5.32813 14.0625 5.6416 14.0625 6.03125V6.96875C14.0625 7.3584 13.749 7.67188 13.3594 7.67188H4.93945L8.46973 11.0352C8.75684 11.3076 8.76269 11.7617 8.48144 12.04Z" fill="#F59300" fill-opacity="0.8"/>
         </svg>'
      )
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
