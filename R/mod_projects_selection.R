#' projects_selection UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_projects_selection_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      column(9),
      column(
        3,
        fixedRow(
          column(
            4,
            p("FR")
          ),
          column(
            4,
            materialSwitch(
              inputId = ns("language")
            )
          ),
          column(
            4,
            p("DE")
          )
        )
      )
    ),
    fluidRow(
      h2("Exploratoire"),
      checkboxGroupInput(
        inputId = ns("theme"),
        label = "Theme",
        choices = letters[1:10],
        inline = TRUE
      ),
      sliderInput(
        inputId = ns("budget"),
        label = "Budget",
        min = 0,
        max = 10^7,
        value = 10^5,
        width = "95%"
      ),
      sliderInput(
        inputId = ns("prop_self_funded"),
        label = "Proportion du budget auto-financee",
        min = 0,
        max = 10^7,
        value = 10^5,
        width = "95%"
      ),
      selectInput(
        inputId = ns("cantons_main_org"),
        label = "Cantons de l'organisation principale",
        choices = letters[1:5],
        multiple = TRUE,
        width = "95%"
      )
    ),
    fluidRow(
      column(8),
      column(
        4,
        actionButton(
          inputId = ns("filter_projects"),
          label = "Filtrer les projets"
        )
      )
    )
  )
}

#' projects_selection Server Functions
#'
#' @noRd
mod_projects_selection_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_projects_selection_ui("projects_selection_1")

## To be copied in the server
# mod_projects_selection_server("projects_selection_1")
