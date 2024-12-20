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
mod_projects_selection_ui <- function(id) {
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
            min = 0,
            max = 6e6,
            value = c(0, 6e6),
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
            value = c(0, 100),
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
          class = "contonpicker",
          pickerInput(
            inputId = ns("cantons_main_org"),
            label = NULL,
            choices = NULL,
            selected = NULL,
            multiple = TRUE,
            options = pickerOptions(
              actionsBox = TRUE
            )
          )
        )
      ),
      div(
        class = "alltitle",
        style = "margin-bottom: 20px",
        "init"
      ) |>
        with_i18n("budget_by_theme"),
      div(
        id = ns("projects_budget_by_theme_plot")
      ),
      div(
        class = "alltitle",
        style = "margin-bottom: 20px",
        "init"
      ) |>
        with_i18n("budget_by_year"),
      div(
        id = ns("projects_year_by_theme_plot")
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
mod_projects_selection_server <- function(id, r_global) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    r_local <- reactiveValues(
      topic = NULL,
      pi1 = NULL,
      pi2 = NULL,
      cantons_main_org = NULL,
      data_budget_by_theme_selected_projects = NULL,
      data_budget_by_year_selected_projects = NULL,
      recompute_graph = TRUE
    )

    # Store state of inputs to be able to preserve them
    # when changing language
    observeEvent(
      input$topic,
      ignoreNULL = FALSE,
      {
        r_local$topic <- input$topic
      }
    )

    observeEvent(
      input$pi1,
      {
        r_local$pi1 <- input$pi1
      }
    )

    observeEvent(
      input$pi2,
      {
        r_local$pi2 <- input$pi2
      }
    )

    observeEvent(
      input$budget_range,
      {
        r_local$budget_range <- input$budget_range
      }
    )
    observeEvent(
      input$prop_self_funded,
      {
        r_local$prop_self_funded <- input$prop_self_funded
      }
    )
    observeEvent(
      input$cantons_main_org,
      {
        r_local$cantons_main_org <- input$cantons_main_org
      }
    )

    # Set initial condition: all projects are displayed
    observeEvent(
      TRUE,
      once = TRUE,
      {
        r_global$selected_projects_sf <- r_global$projects_data_sf
      }
    )

    observeEvent(
      c(
        input$topic,
        input$pi1,
        input$pi2,
        input$budget,
        input$prop_self_funded,
        input$cantons_main_org
      ),
      {
        log_all_current_module_input()
        r_global$selected_projects_sf <- filter_projects_data(
          projects_data_sf = r_global$projects_data_sf,
          vec_topics = input$topic,
          vec_pi_1 = input$pi1,
          vec_pi_2 = input$pi2,
          range_budget = input$budget,
          range_self_funded_budget = input$prop_self_funded,
          cantons_main_org = input$cantons_main_org
        )

        # Make sure graphs are recomputed after each filter
        r_local$recompute_graph <- r_local$recompute_graph + 1
      }
    )


    observeEvent(
      c(r_global$language, r_local$recompute_graph),
      {
        # Budget by theme
        r_local$data_budget_by_theme_selected_projects <-
          get_data_budget_by_theme_selected_projects(
            projects_data_sf = r_global$selected_projects_sf,
            language = r_global$language,
            topic = r_local$topic
          )

        plot_budget_barchart(
          id = ns("projects_budget_by_theme_plot"),
          data_repart = r_local$data_budget_by_theme_selected_projects,
          x_axis_labels = "false",
          axis_max = max(
            r_local$data_budget_by_theme_selected_projects$value
          ),
          axis_interval = 1e7,
          font_size_labels_col = "10px",
          series_name = "",
          prefixer = " CHF",
          session = session
        )

        # Budget by year
        r_local$data_budget_by_year_selected_projects <-
          get_data_budget_by_year_selected_projects(
            projects_data_sf = r_global$selected_projects_sf,
            language = r_global$language
          )

        plot_budget_linechart(
          id = ns("projects_year_by_theme_plot"),
          data_repart = r_local$data_budget_by_year_selected_projects,
          axis_max = max(
            r_local$data_budget_by_year_selected_projects$value
          ),
          axis_interval = 1e7,
          series_name = "",
          prefixer = " CHF",
          session = session
        )
      }
    )

    # Set input value based on app language
    observeEvent(
      r_global$language,
      {
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
          value = r_local$budget_range
        )

        prop_self_funded_range <- get_prop_self_funded_range(
          projects_data_sf = r_global$projects_data_sf
        )
        updateNoUiSliderInput(
          session = session,
          inputId = "prop_self_funded",
          range = prop_self_funded_range,
          value = r_local$prop_self_funded
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
      }
    )
  })
}

## To be copied in the UI
# mod_projects_selection_ui("projects_selection_1")

## To be copied in the server
# mod_projects_selection_server("projects_selection_1")
