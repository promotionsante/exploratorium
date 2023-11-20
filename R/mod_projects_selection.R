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
      h2("Hallo!") |>
        with_i18n("app-title"),
      checkboxGroupInput(
        inputId = ns("theme"),
        label = "Thema(e)" |>
          with_i18n("theme"),
        choices = letters[1:10],
        inline = TRUE
      ),
      sliderInput(
        inputId = ns("budget"),
        label = "Budget" |>
          with_i18n("budget"),
        min = 0,
        max = 10^7,
        value = 10^5,
        width = "95%"
      ),
      sliderInput(
        inputId = ns("prop_self_funded"),
        label = "Selbstfinanzierter Anteil des Budgets"|>
          with_i18n("prop_self_funded"),
        min = 0,
        max = 10^7,
        value = 10^5,
        width = "95%"
      ),
      selectInput(
        inputId = ns("cantons_main_org"),
        label = "Kanton(e) der Hauptorganisation" |>
          with_i18n("cantons_main_org"),
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
          label = "Projekte filtern" |>
            with_i18n("filter_projects")
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
