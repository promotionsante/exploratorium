cli::cat_rule("Connect to shinyapps.io account")

stopifnot(Sys.getenv("SHINYAPPS_IO_NAME") != "")
stopifnot(Sys.getenv("SHINYAPPS_IO_TOKEN") != "")
stopifnot(Sys.getenv("SHINYAPPS_IO_SECRET") != "")

rsconnect::setAccountInfo(
  name = Sys.getenv("SHINYAPPS_IO_NAME"),
  token = Sys.getenv("SHINYAPPS_IO_TOKEN"),
  secret = Sys.getenv("SHINYAPPS_IO_SECRET")
)

# Keep only relevant files

file_to_ignore_regex <- c(
  ".Rprofile$",
  "^.Renviron$",
  "renv/",
  "rstudio_.*/",
  "deliverables/",
  "dev/",
  "data-raw/",
  "dockerfiles/"
) |>
  paste0(
    collapse = "|"
  )
appFiles <- list.files(".", recursive = TRUE)
appFiles <- appFiles[!grepl(
  file_to_ignore_regex,
  appFiles
)]

# Define app name based on current git branch

get_current_git_branch <- function() {
  if (interactive()) {
    # On dev computer
    branch_name <- system("git rev-parse --abbrev-ref HEAD", intern = TRUE)
  } else {
    # ON CI
    branch_name <- c(
      # GITLAB CI
      Sys.getenv("CI_COMMIT_REF_NAME"),
      # GITHUB ACTIONS
      Sys.getenv("GITHUB_REF_NAME")
    )
    branch_name <- branch_name[branch_name != ""]
  }
  return(branch_name)
}

app_name_base <- basename(normalizePath("."))
current_git_branch <- get_current_git_branch()

switch(
  EXPR = current_git_branch,
  "main" = paste0(app_name_base, "-dev"),
  "uat" = paste0(app_name_base, "-uat"),
  "production" = app_name_base,
  "test-ci" = paste0(app_name_base, "-test-ci"),
  stop(
    sprintf(
      "Impossible to deploy from branch '%s'",
      current_git_branch
    )
  )
) -> app_name

cli::cat_rule(
  sprintf("app_name is: %s", app_name)
)

# Deploying app

cli::cat_rule("Deploying app")

options(
  # Tell renv to exclude app from snapshot
  renv.settings.ignored.packages = app_name_base,
  # On ThinkR's workbench the repos option is overloaded
  # The default behaviour of R is to look up all repos to retrieve the most recent package version
  # The usual fix of setting the available_packages_filters does not work here
  # We need to make sure packages are only installed from the CRAN snapshot repos configured on workbench
  repos = c(
    getOption("repos")[names(getOption("repos")) == "CRAN"]
  )
)

getOption("repos")

rsconnect::deployApp(
  appName = app_name,
  appFiles = appFiles,
  forceUpdate = TRUE
)
