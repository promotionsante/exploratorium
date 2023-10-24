library(sf)
library(mapview)


suisse_sf <- st_read(
  dsn = "inst/gadm41_CHE_0.json"
)

cantons_sf <- st_read(
  dsn = "inst/gadm41_CHE_1.json"
)

## Fond de cartes pour maquette

# Suisse entière
mapview(
  x = suisse_sf,
  alpha.regions = 0.1
)


# Cantons
cantons_sf <- cantons_sf |>
  mutate(
    color = case_when(
      HASC_1 %in%  sprintf("CH.%s", c("TI", "GR", "SG")) ~ "darkred",
      TRUE ~ "darkblue"
    )
)

mapview(
  x = cantons_sf,
  alpha.regions = 0.1,
  zcol = "color",
  col.regions = c("darkblue", "darkred")
)
