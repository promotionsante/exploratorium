#' Get budget data by year for selected projects
#'
#' @param projects_data_sf Tibble. Data projects.
#' @param language Character. Language, 'fr' or 'de'.
#'
#' @return A tibble with three columns: `name`, `value` and `value_tooltip`
#'
#' @importFrom sf st_drop_geometry
#' @importFrom dplyr select group_by summarise mutate rename
#' @importFrom scales number
#'
#' @noRd
get_data_budget_by_year_selected_projects <- function(
  projects_data_sf,
  language
) {
  if (language == "fr") {
    word_en <- "en"
    word_cum <- "cumul\u00e9 depuis"
  } else if (language == "de") {
    word_en <- "im Jahr"
    word_cum <- "kumuliert seit"
  }

  projects_data_sf |>
    st_drop_geometry() |>
    mutate(
      # Extract year pattern
      year = gsub(
        pattern = "^\\w+ +(\\d{4})$",
        replacement = "\\1",
        funding_round
      )
    ) |>
    select(
      year,
      budget_gfch
    ) |>
    group_by(year) |>
    summarise(
      sum_value = sum(budget_gfch, na.rm = TRUE),
    ) |>
    mutate(
      value = cumsum(sum_value)
    ) |>
    mutate(
      value_tooltip = paste(
        paste(
          number(
            sum_value,
            suffix = " CHF"
          ),
          word_en,
          year
        ),
        paste(
          number(
            value,
            suffix = " CHF"
          ),
          word_cum,
          min(year)
        ),
        sep = "<br>"
      )
    ) |>
    rename(
      name = year
    )
}
