% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/prepare_app_data.R
\name{prepare_app_data}
\alias{prepare_app_data}
\title{Prepare the projects data in FR and DE to be included in the app as .rds files}
\usage{
prepare_app_data(
  name_raw_file = "PGV.xlsx",
  pkg_dir = system.file(package = "exploratorium"),
  dic_cantons = NULL,
  cantons_sf = NULL
)
}
\arguments{
\item{name_raw_file}{Character. Name of the raw data file.}

\item{pkg_dir}{Character. Path to the package (must contain a data-raw folder).}

\item{dic_cantons}{Tibble. Canton dictionary. Mainly used for examples and unit testing purpose.}

\item{cantons_sf}{Sf data. Cantons geometry. Mainly used for examples and unit testing purpose.}
}
\value{
A list with the projects data in FR and DE.
}
\description{
Prepare the projects data in FR and DE to be included in the app as .rds files
}
