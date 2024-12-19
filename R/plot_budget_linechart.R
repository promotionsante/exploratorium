#' Plot the distribution of the budgets with a linechart
#'
#' @param id Character. Id of the container in the DOM.
#' @param data_repart Tibble. Data to be plotted.
#' @param x_axis_labels Character. Should the labels on the x axis be displayed.
#' @param axis_max Integer. Maximum value for the axis.
#' @param axis_interval Integer. Interval for the axis.
#' @param font_size_labels_col Character. Font size for the labels next to the bars.
#' @param series_name Character. Series name.
#' @param prefixer Character. Prefixer.
#' @param session Session object.
#'
#' @importFrom purrr pmap set_names
#' @importFrom dplyr mutate
#'
#' @return A Java Script plot
#'
#' @noRd
plot_budget_linechart <- function(
  id,
  data_repart,
  x_axis_labels = "true",
  axis_max = 100,
  axis_interval = 20,
  font_size_labels_col = "16px",
  series_name = "",
  prefixer = "%",
  session
) {
  empty_data_provided <- nrow(data_repart) == 0
  if (
    empty_data_provided
  ) {
    session$sendCustomMessage(
      "display_warning_no_available_projects",
      id
    )
    return(NULL)
  }

  # Transform the data in the right format
  data_to_compare <- pmap(
    list(
      data_repart$name,
      data_repart$value,
      data_repart$value_tooltip
    ),
    ~ list(
      name = ..1,
      value = ..2,
      value_tooltip = ..3
    )
  ) |>
    set_names(
      paste0(
        "place",
        seq(from = 1, to = nrow(data_repart), by = 1)
      )
    )

  data <- list(
    id = id,
    plot_options = list(
      x_axis_labels = x_axis_labels,
      axis_max = axis_max,
      axis_interval = axis_interval,
      font_size_labels_col = font_size_labels_col,
      series_name = series_name,
      prefixer = prefixer
    ),
    data_to_compare = data_to_compare
  )

  # Transform the data in the right format
  session$sendCustomMessage(
    type = "createLineChart",
    message = list(
      data
    )
  )
}
