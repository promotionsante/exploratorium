# Before sending to the server

## Update doc
attachment::att_amend_desc(
  path = here::here(),
  extra.suggests = c("rsconnect")
)

## Check the package
devtools::check()

## Increment version number
usethis::use_version("patch")

## Build the pkgdown
pkgdown::build_site()
