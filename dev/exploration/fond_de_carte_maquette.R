library(sf)
library(mapview)
library(dplyr)

suisse_sf <- st_read(
  dsn = "inst/gadm41_CHE_0.json"
)

cantons_sf <- st_read(
  dsn = "inst/gadm41_CHE_1.json"
)

## Fond de cartes pour maquette

# Suisse entière
mapview(
  x = cantons_sf,
  alpha.regions = 0.4,
  col.regions = "#578397"
)


# Cantons
cantons_sf <- cantons_sf |>
  mutate(
    color = case_when(
      HASC_1 %in%  sprintf("CH.%s", c("TI", "GR", "SG")) ~ "target",
      TRUE ~ "others"
    )
)

mapview(
  x = cantons_sf,
  alpha.regions = 0.4,
  zcol = "color",
  col.regions =  c("#578397", "#f59300")
)
