# Identify functions that are not in the flat files anymore ----

identify_fct_in_flat <- function(name_flat_rmd) {

  flat_in_line <- readLines(file.path("dev", name_flat_rmd))

  names_fct_in_flat <- flat_in_line[which(stringr::str_detect(flat_in_line, "```\\{r function-"))] %>%
    stringr::str_remove_all("```\\{r function-") %>%
    stringr::str_remove_all("\\}")

  return(names_fct_in_flat)

}
fct_in_flat_files <- list.files("dev")[list.files("dev") %>% stringr::str_detect("^flat")] %>%
  purrr::map(identify_fct_in_flat) %>%
  unlist() %>%
  stringr::str_c(".R")
fct_in_r_folder <- list.files("R")
obsolete_fcts <- fct_in_r_folder[!(fct_in_r_folder %in% fct_in_flat_files)]
obsolete_fcts <- obsolete_fcts[!grepl("app|mod_|zzz|listofcodes-package|utils-pipe|welcome_banner", obsolete_fcts)]
obsolete_fcts
# should be empty
# if this is not the case -> delete these functions in /R, /man and /test


# Inflate all flat files ----
fusen::inflate_all_no_check()

# Update the documentation ----
# attachment::att_amend_desc(
#   pkg_ignore = c("whereami", "flat_in_line", "listofcodesadmin"),
#   extra.suggests = c("DT", "knitr",
#                      "whereami", "dbplyr",
#                      "markdown", "pkgload"),
#   use.config = FALSE
# )

# Check the package ----
devtools::check()
