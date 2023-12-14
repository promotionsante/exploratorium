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
          with_i18n("topic"),

        div(
          class = "custom-checkbox custom-checkbox-2col",
          awesomeCheckboxGroup(
            inputId = ns("topic"),
            label = NULL,
            choices = NULL,
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
            max = 6e6,
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
            value = c(20, 40),
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
              actionsBox = TRUE
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
#' @importFrom shinyWidgets updateAwesomeCheckboxGroup updateNoUiSliderInput
#' @importFrom shinyWidgets updatePickerInput
#'
#' @noRd
mod_projects_selection_server <- function(id, r_global){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    r_local <- reactiveValues(
      topic = NULL,
      pi1 = NULL,
      pi2 = NULL,
      cantons_main_org = NULL
    )

    # Store state of inputs to be able to preserve them
    # when changing language
    observeEvent(
      input$topic, {
        r_local$topic <- input$topic
      })
    observeEvent(
      input$pi1, {
        r_local$pi1 <- input$pi1
      })
    observeEvent(
      input$pi2, {
        r_local$pi2 <- input$pi2
      })
    observeEvent(
      input$cantons_main_org, {
        r_local$cantons_main_org <- input$cantons_main_org
      })

    # Set initial condition: all projects are displayed
    observeEvent(
      TRUE,
      once = TRUE, {
        r_global$selected_projects_sf <- r_global$projects_data_sf
      })
    observeEvent(
      input$filter_projects, {
        log_all_current_module_input()
        r_global$selected_projects_sf <- filter_projects_data(
          projects_data_sf = r_global$projects_data_sf,
          vec_topics = input$topic,
          vec_pi_1 = input$pi1,
          vec_pi_2 = input$pi2,
          range_budget = input$budget,
          range_self_funded_budget = input$prop_self_funded,
          cantons_main_org =  input$cantons_main_org
        )
      })

    observeEvent(
      r_global$language, {

        updateAwesomeCheckboxGroup(
          session = session,
          inputId = "topic",
          choices = get_topics_to_display(
            language = r_global$language
          ),
          selected = r_local$topic,
          status = "warning"
        )

        updateAwesomeCheckboxGroup(
          session = session,
          inputId = "pi1",
          choices = get_pi1_to_display(
            language = r_global$language
          ),
          status = "warning",
          selected = r_local$pi1
        )
        updateAwesomeCheckboxGroup(
          session = session,
          inputId = "pi2",
          choices = get_pi2_to_display(
            language = r_global$language
          ),
          status = "warning",
          selected = r_local$pi2
        )

        budget_range <- get_budget_range(
          projects_data_sf = r_global$projects_data_sf
        )
        updateNoUiSliderInput(
          session = session,
          inputId = "budget",
          range = budget_range,
          value = budget_range
        )

        prop_self_funded_range <- get_prop_self_funded_range(
          projects_data_sf = r_global$projects_data_sf
        )
        updateNoUiSliderInput(
          session = session,
          inputId = "prop_self_funded",
          range = prop_self_funded_range,
          value = prop_self_funded_range
        )

        updatePickerInput(
          session = session,
          inputId = "cantons_main_org",
          choices = get_cantons_main_org(
            projects_data_sf = r_global$projects_data_sf
          ),
          selected = r_local$cantons_main_org,
          options = pickerOptions(
            title = translate_entry_server_side(
              language = r_global$language,
              key = "cantons_main_org_title"
            ),
            selectAllText = translate_entry_server_side(
              language = r_global$language,
              key = "cantons_main_org_select_all_text"
            ),
            deselectAllText = translate_entry_server_side(
              language = r_global$language,
              key = "cantons_main_org_deselect_all_text"
            )
          )
        )
      })



  })
}

## To be copied in the UI
# mod_projects_selection_ui("projects_selection_1")

## To be copied in the server
# mod_projects_selection_server("projects_selection_1")
