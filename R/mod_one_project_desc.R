#' project UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_one_project_desc_ui <- function(id){

  ns <- NS(id)

  tagList(

    uiOutput(
      outputId = ns("project_card")
    ),

    div(
      id = ns("project_repart_budget_plot")
    )


  )
}

#' project Server Functions
#'
#' @importFrom glue glue
#'
#' @noRd
mod_one_project_desc_server <- function(id, r_global){

  moduleServer( id, function(input, output, session){

    ns <- session$ns

    r_local <- reactiveValues(
      card_ui = NULL
    )

    observeEvent(
      input$back_to_project_selection_view,
      {
        r_global$id_selected_project <- NULL
      })

    observeEvent(
      r_global$click_map,
      {
        if (r_global$click_map == "click-on-map-in-project-view") {
          r_global$id_selected_project <- NULL
        }
      })

    observeEvent(
      c(
        r_global$id_selected_project,
        r_global$language
      ),
      {

        clean_id_project <- clean_id_project(
          id_project = r_global$id_selected_project
        )

        language <- r_global$language

        if (
          is.null(r_global$id_selected_project)
        ) {

          r_local$card_ui <- tags$script('$("#project_selection_panel").show()')

        } else {

          r_local$card_ui <- tagList(
            actionButton(
              inputId = ns("back_to_project_selection_view"),
              label = NULL,
              icon = NULL,
              width = "0%",
              class = "orange-arrow-button",
              get_back_arrow_html()
            ),
            includeHTML(
              system.file(
                "data-projects-cards",
                glue("project_card_{clean_id_project}_{language}.html"),
                package = "observatoire"
              )
            ),
            tags$script('$("#project_selection_panel").hide()')
          )

          plot_contrib_budget_highcharter(
            id = ns("project_repart_budget_plot"),
            data_repart = get_data_repart_budget_one_project(
              data_projects = r_global$projects_data_sf,
              id_project = r_global$id_selected_project,
              language = language
            ),
            session = session
          )
        }

      })

    output$project_card <- renderUI({
      r_local$card_ui
    })

  })

}

## To be copied in the UI
# mod_one_project_desc_ui("project_1")

## To be copied in the server
# mod_one_project_desc_server("project_1")
