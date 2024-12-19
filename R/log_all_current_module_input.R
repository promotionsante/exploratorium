#' Log values for all input inside the current module
#'
#' @param session A shiny session object
#'
#' @return Nothing. Used for its side effect of printing
#' information into the console.
#'
#' @importFrom cli cat_rule cli_alert
#' @noRd
log_all_current_module_input <- function(
  session = shiny::getDefaultReactiveDomain()) {
  current_module <- sub(
    "-$",
    "",
    session$ns("")
  )

  cat_rule(
    paste(
      "Inputs value from:",
      current_module
    )
  )

  for (
    name in names(session$input)
  ) {
    cli_alert(
      sprintf(
        "%s: %s",
        name,
        paste(
          session$input[[name]],
          collapse = ", "
        )
      )
    )
  }
}
