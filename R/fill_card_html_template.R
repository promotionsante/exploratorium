get_dic_titles_app <- function(language) {
  dic_titles_pages <- read_csv2(
    app_sys("data-dic", "dic_titles_app.csv"),
    show_col_types = FALSE,
    locale = locale(decimal_mark = ",", grouping_mark = ".")
  )
  # Get a list with one element per title id
  dic_titles_pages |>
    getElement(language) |>
    as.list() |>
    setNames(dic_titles_pages$id)
}

#' @importFrom lubridate interval int_length
#' @noRd
compute_project_completion_percentage <- function(
  date_project_start,
  date_project_end
) {
  if (Sys.Date() > date_project_end) {
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

  # If current date is before start date set project completion to zero
  if (completion_percentage < 0) {
    completion_percentage <- 0
  }

  return(completion_percentage)
}


derive_project_manager_api_query_string <- function(
  project_manager_chr) {
  project_manager_chr |>
    switch(
      "Franziska Widmer Howald" = "franziska.widmer",
      "Rapha\u00ebl Tr\u00e9meaud" = "raphael.tremeaud",
      "Karin Wyss M\u00fcller" = "karin.wyss",
      "Karin L\u00f6rvall" = "karin.loervall"
    )
}

#' Extracts Items from binary columns (`topic_*`, `risk_factors_*`)
#'
#' and translate them in the target language.
#'
#' @param data_one_project A data frame containing project data.
#' @param binary_colum_prefix A character. Binary column prefix .i.e "topic"
#' @param language A character string specifying the language for translation.
#' @return A character vector of translated items.
#'
#' @importFrom dplyr select starts_with filter pull
#' @importFrom tidyselect everything
#' @importFrom sf st_drop_geometry
#' @importFrom tidyr pivot_longer
#'
#' @noRd
get_project_items_from_binary_columns <- function(
  data_one_project,
  binary_colum_prefix,
  language
) {
  data_topic <- data_one_project |>
    select(starts_with(binary_colum_prefix)) |>
    st_drop_geometry() |>
    pivot_longer(
      cols = everything(),
      names_to = "item",
      values_to = "presence"
    ) |>
    translate_values_in_col(
      col_to_translate = "item",
      language = language,
      dictionary = "dic_variables.csv"
    ) |>
    filter(presence) |>
    pull(item)
}

#' Fill projects cards HTML template
#'
#' @param id_project Character. ID of the project, 'short_title' in data.
#' @param data_projects Tibble. Data projects.
#' @param language Character. Language, 'fr' or 'de'.
#'
#' @importFrom htmltools htmlTemplate withTags
#' @importFrom glue glue
#' @importFrom purrr map set_names
#' @importFrom dplyr filter
#' @importFrom lubridate year
#' @importFrom scales number
#'
#' @return shiny tag list to be rendered as a procject card
#'
#' @noRd
fill_card_html_template <- function(
  id_project,
  data_projects,
  language = c("de", "fr")
) {
  language <- match.arg(language)

  list_titles <- get_dic_titles_app(
    language = language
  )

  data_one_project <- data_projects |>
    filter(short_title == id_project)

  short_title_value <- data_one_project[["short_title"]]
  status_value <- data_one_project[["status"]]

  if (language == "de") {
    possible_col_status <- c(
      "Abschluss" = psch_yellow(),
      "Umsetzung" = psch_green(),
      "Abbruch" = psch_bronce()
    )
  } else if (language == "fr") {
    possible_col_status <- c(
      "Termin\u00e9" = psch_yellow(),
      "En cours" = psch_green(),
      "Annul\u00e9" = psch_bronce()
    )
  }

  status_color <- possible_col_status[status_value]

  start_year_value <- year(data_one_project[["project_start"]])

  project_manager <- data_one_project[["project_support_gfch"]]
  project_manager_url <-
    paste0(
      "https://promotionsante.ch/fondation/equipe?views_search_api_fulltext=",
      derive_project_manager_api_query_string(project_manager)
    )
  project_manager_value <- glue(
    '<a href=\"{project_manager_url}\" target=\"_blank\">{project_manager}</a>'
  )

  main_orga_value <- data_one_project[["main_resp_orga"]]

  description_value <- data_one_project[["description"]]

  completion_percentage <- compute_project_completion_percentage(
    date_project_start = data_one_project$project_start,
    date_project_end = data_one_project$project_end
  )

  if (language == "de") {
    more_description_value <- 'Weitere informationen finden sie auf der <a href=\"https://gesundheitsfoerderung.ch/praevention-in-der-gesundheitsversorgung/projektfoerderung/gefoerderte-projekte\" target=\"_blank\">website von Gesundheitf\u00f6rdernung Schweiz</a>'
  } else if (language == "fr") {
    more_description_value <- 'Vous trouverez des informations compl\u00e9mentaires  sur le <a href=\"https://promotionsante.ch/prevention-dans-le-domaine-des-soins/soutien-de-projets/projets-soutenus\" target=\"_blank\">site de Promotion Sant\u00e9 Suisse</a>'
  }

  data_topic <- get_project_items_from_binary_columns(
    data_one_project = data_one_project,
    binary_colum_prefix = "topic",
    language = language
  )
  theme_value <- sprintf("<li>%s</li>", data_topic)

  data_risk_factors <- get_project_items_from_binary_columns(
    data_one_project = data_one_project,
    binary_colum_prefix = "risk_factor",
    language = language
  )
  risk_value <- sprintf("<li>%s</li>", data_risk_factors)

  budget_value <- number(
    as.numeric(data_one_project[["total_budget"]]),
    suffix = " CHF"
  )

  # Generate the html content
  html_content <- htmlTemplate(
    filename = app_sys(
      "template_projects_cards.html"
    ),
    short_title_value = short_title_value,
    status_color = status_color,
    status_value = status_value,
    project_start_year_title = list_titles[["project_start_year_title"]],
    project_project_manager_title = HTML(list_titles[["project_project_manager_title"]]),
    project_main_orga_title = list_titles[["project_main_orga_title"]],
    start_year_value = start_year_value,
    project_manager_value = HTML(project_manager_value),
    main_orga_value = main_orga_value,
    project_advancement = list_titles[["project_advancement"]],
    start_year = year(data_one_project$project_start),
    completion_percentage = completion_percentage,
    end_year = year(data_one_project$project_end),
    project_description_title = list_titles[["project_description_title"]],
    description_value = HTML(description_value),
    more_description_value = HTML(more_description_value),
    project_theme_title = list_titles[["project_theme_title"]],
    theme_value = HTML(theme_value),
    project_risk_title = list_titles[["project_risk_title"]],
    risk_value = HTML(risk_value),
    project_budget_title = list_titles[["project_budget_title"]],
    budget_value = budget_value,
    project_prop_budget_title = list_titles[["project_prop_budget_title"]]
  )

  return(html_content)
}
