#' @inheritParams get_input_data_to_display
#'
#' @noRd
#' @examples
#' get_pi1_to_display("fr")
get_pi1_to_display <- function(language){
  pi1_to_display <- get_input_data_to_display(
    language = language,
    pattern = "^pi_1_"
  )
  # Remove PI 1 prefix
  names(pi1_to_display) <- gsub(
    pattern = "PI 1 *: ",
    replacement = "",
     names(pi1_to_display)
  )
  return(pi1_to_display)
}
