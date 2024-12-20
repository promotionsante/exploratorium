#' Add start-up screen
#'
#' Wait until the app is ready to display UI
#'
#' @importFrom waiter useWaiter waiterPreloader spin_pulsar
#' @noRd
startup_screen <- function() {
  tagList(
    useWaiter(),
    waiterPreloader(
      html = spin_pulsar(),
      # Same color as --beige-background in custom.css
      color = "#FAFAF8"
    )
  )
}

#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      startup_screen(),
      div(
        class = "container-map",
        column(
          width = 9,
          mod_map_ui("map_1"),
        )
      ),
      column(
        width = 3,
        div(
          class = "container-project",
          mod_right_panel_ui("right_panel_1"),
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(
      ext = "png"
    ),
    tags$script(
      src = "https://code.highcharts.com/12.0.0/highcharts.js"
    ),
    tags$script(
      src = "https://code.highcharts.com/12.0.0/modules/accessibility.js"
    ),
    tags$script(
      src = "https://code.highcharts.com/12.0.0/modules/exporting.js"
    ),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "exploratorium"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
