#' one_project UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_one_project_ui <- function(id) {
  ns <- NS(id)

  tagList(
    uiOutput(
      outputId = ns("project_card")
    )
  )
}

#' one_project Server Functions
#'
#' @noRd
mod_one_project_server <- function(id, r_global) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    r_local <- reactiveValues(
      card_ui = NULL
    )

    # Take user back to project selection view
    observeEvent(
      input$back_to_project_selection_view,
      {
        r_global$id_selected_project <- NULL
      }
    )
    observeEvent(
      r_global$click_map,
      {
        if (r_global$click_map == "click-on-map-in-project-view") {
          r_global$id_selected_project <- NULL
        }
      }
    )

    # Construct card to be displayed based on project id and app language
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
            fill_card_html_template(
              id_project = r_global$id_selected_project,
              data_projects = r_global$projects_data_sf,
              language = r_global$language
            ),
            div(
              id = ns("project_repart_budget_plot")
            ),
            tags$script('$("#project_selection_panel").hide()')
          )

          # Make sure div graph div is removed if it already exists
          # This make sure the graph is updated after the renderUI
          session$sendCustomMessage(
            "remove_id_if_existing_in_dom",
            ns("project_repart_budget_plot")
          )

          plot_budget_barchart(
            id = ns("project_repart_budget_plot"),
            data_repart = get_data_repart_budget_one_project(
              data_projects = r_global$projects_data_sf,
              id_project = r_global$id_selected_project,
              language = language
            ),
            session = session
          )
        }
      }
    )

    output$project_card <- renderUI({
      r_local$card_ui
    })
  })
}

## To be copied in the UI
# mod_one_project_ui("one_project_1")

## To be copied in the server
# mod_one_project_server("one_project_1")
