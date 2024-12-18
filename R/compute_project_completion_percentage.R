#' @importFrom lubridate interval int_length
#' @noRd
#' @examples
#' compute_project_completion_percentage(
#'   date_project_start = as.Date("2023-01-01"),
#'   date_project_end = as.Date("2026-12-31")
#' )
compute_project_completion_percentage <- function(
    date_project_start,
    date_project_end
) {

  if (Sys.Date() > date_project_end ) {
    completion_percentage <- 100
    return(completion_percentage)
  }

  whole_project_duration <- interval(
    start = date_project_start,
    end = date_project_end
  ) |> int_length()

  current_state <- interval(
    start = date_project_start,
    end = Sys.Date()
  ) |> int_length()


  completion_percentage <- round(
    x = (current_state / whole_project_duration) * 100,
    digits = 0
  )

  return(completion_percentage)
}

