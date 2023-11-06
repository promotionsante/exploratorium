# Before sending to the server

## Inflate all flat files
fusen::inflate_all_no_check()

## Update doc
attachment::att_amend_desc(
  path = here::here(),
  extra.suggests = c("rsconnect", "cli")
)

## Check the package
devtools::check()

## Build the pkgdown
pkgdown::build_site()
