#' projects_selection UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom shinyWidgets noUiSliderInput wNumbFormat awesomeCheckboxGroup pickerInput pickerOptions
mod_projects_selection_ui <- function(id){
  ns <- NS(id)

  tagList(

    div(

      class = "globalpanel",

      div(
        class = "apptitle",
        "init"
      ) |>
        with_i18n("app-title"),

      div(
        class = "appdesc",
        "init"
      ) |>
        with_i18n("app-desc"),

      div(

        div(
          class = "alltitle",
          style = "margin-bottom: 20px",
          "init"
        ) |>
          with_i18n("theme"),

        div(
          class = "custom-checkbox custom-checkbox-2col",
          awesomeCheckboxGroup(
            inputId = ns("theme"),
            label = NULL,
            choices =
              c(
                sort(
                  c(
                    "Erkrankungen der Atemwege",
                    "Diabetes",
                    "Herz-Kreislauf-Erkrankungen",
                    "Krebserkrankungen",
                    "Muskuloskelettale Erkrankungen",
                    "Psychische Krankheiten",
                    "S\u00fcchte"
                  )
                ),
                "Andere NCDs",
                "Andere"
              ),
            status = "warning"
          )
        )

      ),

      div(

        class = "two-column-div",

        div(

          div(
            class = "alltitle",
            style = "margin-bottom: 20px;",
            "init"
          ) |>
          with_i18n("pi1"),

          div(
            class = "custom-checkbox",
            awesomeCheckboxGroup(
              inputId = ns("pi1"),
              label = NULL,
              choices =
                sort(
                  c(
                    "Schnittstellen",
                    "Gesundheitspfade",
                    "Selbstmgmt"
                  )
                ),
              status = "warning"
            )
          )
        ),

        div(

          div(
            class = "alltitle",
            style = "margin-bottom: 20px;",
            "init"
          ) |>
          with_i18n("pi2"),

          div(
            class = "custom-checkbox",
            awesomeCheckboxGroup(
              inputId = ns("pi2"),
              label = NULL,
              choices =
                sort(
                  c(
                    "AWF-bildung",
                    "Neue Tech",
                    "Wirschaftl"
                  )
                ),
              status = "warning"
            )
          )
      )

    ),

      div(

        div(
          class = "alltitle",
          style = "margin-bottom: 20px",
          "init"
        ) |>
          with_i18n("budget"),

        div(
          style = "margin-top: 50px",
          noUiSliderInput(
            inputId = ns("budget"),
            label = NULL,
            min = 100000,
            max = 5571018,
            value = c(2000000, 3000000),
            width = "100%",
            color = "#578397",
            format = wNumbFormat(
              decimals = 0,
              thousand = " ",
              suffix = " CHF"
            )
          )
        )

      ),

      div(

        div(
          class = "alltitle",
          style = "margin-bottom: 20px",
          "init"
        ) |>
          with_i18n("prop_self_funded"),

        div(
          style = "margin-top: 50px",
          noUiSliderInput(
            inputId = ns("prop_self_funded"),
            label = NULL,
            min = 0,
            max = 100,
            value = c(20, 80),
            width = "100%",
            color = "#578397",
            format = wNumbFormat(
              decimals = 0,
              suffix = " %"
            )
          )
        )

      ),

      div(

        div(
          class = "alltitle",
          style = "margin-bottom: 20px",
          "init"
        ) |>
          with_i18n("cantons_main_org"),

        div(
          pickerInput(
            inputId = ns("cantons_main_org"),
            label = NULL,
            choices = c("AI", "AR", "BG"),
            selected = c("AI", "AR", "BG"),
            multiple = TRUE,
            width = "100%",
            options = pickerOptions(
              actionsBox = TRUE,
              title = "Bitte Kantone ausw\u00e4hlen",
              selectAllText = "Alle ausw\u00e4hlen",
              deselectAllText = "Alle abw\u00e4hlen"
            )
          )
        )
      ),

      div(
        actionButton(
          inputId = ns("filter_projects"),
          label = "Projekte filtern" |>
            with_i18n("filter_projects"),
          class = "filter-projects-button"
        )
      )

    )

  )
}

#' projects_selection Server Functions
#'
#' @noRd
mod_projects_selection_server <- function(id, r_global){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # Set initial condition: all projects are displayed
    observeEvent(
      TRUE,
      once = TRUE, {
        r_global$selected_projects_sf <- r_global$projects_data_sf
      })
    observeEvent(
      input$filter_projects, {
        r_global$selected_projects_sf <- filter_projects_data(
          projects_data_sf = r_global$projects_data_sf
        )
      })

  })
}

## To be copied in the UI
# mod_projects_selection_ui("projects_selection_1")

## To be copied in the server
# mod_projects_selection_server("projects_selection_1")
