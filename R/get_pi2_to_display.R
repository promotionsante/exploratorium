#' @inheritParams get_input_data_to_display
#'
#' @noRd
get_pi2_to_display <- function(language) {
  pi1_to_display <- get_input_data_to_display(
    language = language,
    pattern = "^pi_2_"
  )
  # Remove PI 1 prefix
  names(pi1_to_display) <- gsub(
    pattern = "PI 2 *: ",
    replacement = "",
    names(pi1_to_display)
  )
  return(pi1_to_display)
}
