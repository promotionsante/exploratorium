# Before sending to the server

## Inflate all flat files
fusen::inflate_all_no_check()

## Update doc
# attachment::att_amend_desc(
#   pkg_ignore = "",
#   extra.suggests = ""
# )

## Run the examples
devtools::run_examples()

## Run the unit tests
devtools::test()

## Check the package
devtools::check(args = c("--no-examples", "--no-tests"))

## Build the pkgdown
pkgdown::build_site()
