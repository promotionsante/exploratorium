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
          with_i18n("topic"),

        div(
          class = "custom-checkbox",
          checkboxGroupInput(
            inputId = ns("topic"),
            label = NULL,
            choices = NULL,
          )
        )

      ),

      div(

        div(
          class = "alltitle",
          style = "margin-bottom: 20px",
          "init"
        ) |>
          with_i18n("pi1"),

        div(
          class = "custom-checkbox",
          checkboxGroupInput(
            inputId = ns("pi1"),
            label = NULL,
            choices =
              sort(
                c(
                  "Schnittstellen",
                  "Gesundheitspfade",
                  "Selbstmgmt"
                )
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
          with_i18n("pi2"),

        div(
          class = "custom-checkbox",
          checkboxGroupInput(
            inputId = ns("pi2"),
            label = NULL,
            choices =
              sort(
                c(
                  "AWF-bildung",
                  "Neue Tech",
                  "Wirschaftl"
                )
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
          sliderInput(
            inputId = ns("budget"),
            label = NULL,
            min = 0,
            max = 10^7,
            value = 10^5,
            width = "95%"
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
          sliderInput(
            inputId = ns("prop_self_funded"),
            label = NULL,
            min = 0,
            max = 10^7,
            value = 10^5,
            width = "95%"
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
          selectInput(
            inputId = ns("cantons_main_org"),
            label = NULL,
            choices = letters[1:5],
            multiple = TRUE,
            width = "95%"
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

    r_local <- reactiveValues(
      topic = NULL,
      pi1 = NULL,
      pi2 = NULL
    )

    # Store state of inputs to be able to preserve them
    # when changing language
    observeEvent(
      input$topic, {
        r_local$topic <- input$topic
        r_local$pi1 <- input$pi1
        r_local$pi2 <- input$pi2
      })

    # Set initial condition: all projects are displayed
    observeEvent(
      TRUE,
      once = TRUE, {
        r_global$selected_projects_sf <- r_global$projects_data_sf
      })
    observeEvent(
      input$filter_projects, {
        r_global$selected_projects_sf <- filter_projects_data(
          projects_data_sf = r_global$projects_data_sf,
          vec_topics = input$topic
        )
      })

    observeEvent(
      r_global$language, {

        updateCheckboxGroupInput(
          inputId = "topic",
          choices = get_topics_to_display(
            language = r_global$language
          ),
          selected = r_local$topic
        )

        updateCheckboxGroupInput(
          inputId = "pi1",
          choices = get_pi1_to_display(
            language = r_global$language
          ),
          selected = r_local$pi1
        )
        updateCheckboxGroupInput(
          inputId = "pi2",
          choices = get_pi2_to_display(
            language = r_global$language
          ),
          selected = r_local$pi2
        )

        budget_range <- get_budget_range(
          projects_data_sf = r_global$projects_data_sf
        )
        updateSliderInput(
          inputId = "budget",
          min = budget_range[1],
          max = budget_range[2]
        )

        prop_self_funded_range <- get_prop_self_funded_range(
          projects_data_sf = r_global$projects_data_sf
        )
        updateSliderInput(
          inputId = "prop_self_funded",
          min = prop_self_funded_range[1],
          max = prop_self_funded_range[2]
        )

        updateSelectInput(
          inputId = "cantons_main_org",
          choices = get_cantons_main_org(
            projects_data_sf = r_global$projects_data_sf
          )
        )
      })



  })
}

## To be copied in the UI
# mod_projects_selection_ui("projects_selection_1")

## To be copied in the server
# mod_projects_selection_server("projects_selection_1")
