# This file is a template to be used as a .Rprofile in gitlab CI
# To set repos to the CRAN snapshot date as ThinkR dev environment
repos <- c(CRAN = "https://packagemanager.posit.co/cran/__linux__/jammy/2023-11-09")
message(
  sprintf(
    "[CI specific Rprofile] Installing packages from %s:",
    repos
  )
)
options( repos = repos)
