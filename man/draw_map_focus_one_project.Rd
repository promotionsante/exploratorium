% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/draw_map_focus_one_project.R
\name{draw_map_focus_one_project}
\alias{draw_map_focus_one_project}
\title{Draw the map focused on one project}
\usage{
draw_map_focus_one_project(
  projects_data_sf,
  id_project,
  cantons_sf = NULL,
  zoom_level = 8
)
}
\arguments{
\item{projects_data_sf}{A sf data.frame containing coordinates of project
main organisation and project `short_title`.}

\item{id_project}{Character. Id of the project.}

\item{cantons_sf}{Sf data. Cantons geometry. Mainly used for examples and unit testing purpose.}

\item{zoom_level}{An integer. The zoom level for the map. Defines
default zoom level.}
}
\value{
A leaflet object.
}
\description{
Draw the map focused on one project
}
\examples{
data("toy_projects_data_sf")
data("toy_cantons_sf")

draw_map_focus_one_project(
  projects_data_sf = toy_projects_data_sf,
  id_project = "1+1=3  PGV03.038",
  cantons_sf = toy_cantons_sf
)
}
