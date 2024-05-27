#' Get budget data by theme for selected projects
#'
#' @param projects_data_sf Tibble. Data projects.
#' @param language Character. Language, 'fr' or 'de'.
#' @param topic Character. A specific topic/theme in the form topic_
#'
#' @return A tibble with three columns: `name`, `value` and `value_tooltip`
#'
#' @importFrom sf st_drop_geometry
#' @importFrom dplyr select starts_with filter group_by summarise mutate inner_join all_of arrange desc
#' @importFrom tidyr pivot_longer
#' @importFrom scales number
#' @importFrom readr read_csv2
#'
#'
#' @noRd
#' @examples
#' data("toy_projects_data_sf")
#'
#' get_data_budget_by_theme_selected_projects(
#'   projects_data_sf = toy_projects_data_sf,
#'   language = "fr"
#' )
#'
#' get_data_budget_by_theme_selected_projects(
#'   projects_data_sf = toy_projects_data_sf,
#'   language = "fr",
#'   topic = "topic_diabetes"
#' )
#'
#' get_data_budget_by_theme_selected_projects(
#'   projects_data_sf = toy_projects_data_sf,
#'   language = "fr",
#'   topic = c(
#'     "topic_diabetes",
#'     "topic_addictions"
#'   )
#'
#' )
get_data_budget_by_theme_selected_projects <- function(
    projects_data_sf,
    language,
    topic = NULL
) {

  data_graph_topic <-  projects_data_sf |>
    st_drop_geometry() |>
    select(
      starts_with("topic_"),
      total_budget
    ) |>
    pivot_longer(
      cols = starts_with("topic_"),
      names_to = "name",
      values_to = "present"
    ) |>
    filter(
      present
    ) |>
    group_by(name) |>
    summarise(
      value = sum(total_budget, na.rm = TRUE)
    ) |>
    mutate(
      value_tooltip = number(
        value,
        suffix = " CHF"
      )
    )

  # Filter only a specific project
  if (!is.null(topic)) {
    data_graph_topic <- data_graph_topic |>
      filter(name %in% topic)
  }

  dic_variables <- suppressMessages(
    read_csv2(
      file = app_sys("data-dic/dic_variables.csv"),
      show_col_types = FALSE
    )
  )

  data_graph_topic_translated <- data_graph_topic |>
    inner_join(
      dic_variables,
      by = c("name" = "name_variable")
    ) |>
    select(
      name = all_of(language),
      value,
      value_tooltip
    ) |>
    arrange(
      desc(value)
    )

  return(data_graph_topic_translated)
}
