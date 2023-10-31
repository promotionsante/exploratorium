# Before sending to the server

## Inflate all flat files
fusen::inflate_all_no_check()

## Update doc
# attachment::att_amend_desc(
#   pkg_ignore = "",
#   extra.suggests = ""
# )


## Check the package
devtools::check()

## Build the pkgdown
pkgdown::build_site()
