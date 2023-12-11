#' one_project_plot UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_one_project_plot_ui <- function(id){

  ns <- NS(id)

  tagList(


  )

}

#' one_project_plot Server Functions
#'
#' @noRd
mod_one_project_plot_server <- function(id, r_global){

  moduleServer( id, function(input, output, session){

    ns <- session$ns

  })

}

## To be copied in the UI
# mod_one_project_plot_ui("one_project_plot_1")

## To be copied in the server
# mod_one_project_plot_server("one_project_plot_1")
