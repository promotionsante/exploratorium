################################################
##    SCRIPT FOR PREPARING TOY DATASET FOR    ##
#           EXAMPLES AND UNIT TESTS            #
################################################

## code to prepare `toy_data_pgv` ----

toy_data_pgv <- read_excel(
  path = system.file(
    "data-projects-raw",
    "PGV.xlsx",
    package = "observatoire"
  )
) |>
  slice(1:5)

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

