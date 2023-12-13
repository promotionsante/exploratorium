################################################
##    SCRIPT FOR PREPARING TOY DATASET FOR    ##
#           EXAMPLES AND UNIT TESTS            #
################################################

pkgload::load_all()
library(readxl)
library(readr)
library(dplyr)

## code to prepare `toy_data_pgv` ----

toy_data_pgv <- read_excel(
  path = system.file(
    "data-projects-raw",
    "PGV.xlsx",
    package = "observatoire"
  )
) |>
  slice(
    # First line inlcuding extra French title line to clean
    1:5,
    # Project with peculiar topic data weird separator or entirely missing data
    grep(
      pattern = paste(
        "Antalgie",
        "FM_ProPCC",
        sep = "|"
      ),
      x = Kurztitel
    )
  )

usethis::use_data(
  toy_data_pgv,
  overwrite = TRUE
)

checkhelper::use_data_doc(
  name = "toy_data_pgv"
)

## code to prepare `toy_dic_variables` ----
toy_dic_variables <- read_csv2(
  system.file(
    "data-dic",
    "dic_variables.csv",
    package = "observatoire"
  ),
  show_col_types = FALSE
)

usethis::use_data(
  toy_dic_variables,
  overwrite = TRUE
)

checkhelper::use_data_doc(
  name = "toy_dic_variables"
)

## code to prepare `toy_dic_cantons` ----
toy_dic_cantons <- read_csv(
  system.file(
    "data-dic",
    "dic_cantons.csv",
    package = "observatoire"
  ),
  show_col_types = FALSE
)

usethis::use_data(
  toy_dic_cantons,
  overwrite = TRUE
)

checkhelper::use_data_doc(
  name = "toy_dic_cantons"
)

## code to prepare `toy_cantons_sf` ----
toy_cantons_sf <- st_read(
  dsn = system.file(
    "data-geo",
    "gadm41_CHE_1.json",
    package = "observatoire"
  )
)

usethis::use_data(
  toy_cantons_sf,
  overwrite = TRUE
)

checkhelper::use_data_doc(
  name = "toy_cantons_sf"
)

## code to prepare `toy_projects_data_sf` ----
toy_projects_data_sf <- readRDS(
  system.file(
    "data-projects",
    "projects_de.rds",
    package = "observatoire"
  )
)

usethis::use_data(
  toy_projects_data_sf,
  overwrite = TRUE
)

checkhelper::use_data_doc(
  name = "toy_projects_data_sf"
)

## code to prepare `toy_dic_titles_pages` ----
toy_dic_titles_pages <- read_csv2(
  app_sys("data-dic",
          "dic_titles_app.csv"),
  show_col_types = FALSE,
  locale = locale(decimal_mark = ",", grouping_mark = ".")
)

usethis::use_data(
  toy_dic_titles_pages,
  overwrite = TRUE
)

checkhelper::use_data_doc(
  name = "toy_dic_titles_pages"
)

## code to prepare `toy_dic_values` ----
toy_dic_values <- read_csv2(
  app_sys("data-dic",
          "dic_values.csv"),
  show_col_types = FALSE,
  locale = locale(decimal_mark = ",", grouping_mark = ".")
)

usethis::use_data(
  toy_dic_values,
  overwrite = TRUE
)

checkhelper::use_data_doc(
  name = "toy_dic_values"
)
