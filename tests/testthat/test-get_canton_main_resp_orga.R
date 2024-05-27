test_that("Test that the detection of the canton is ok", {

  toy_data <-
    structure(
      list(
        short_title = c(
          "1+1=3  PGV03.038",
          "Action Diab\u00e8te PGV01.057",
          "Angeh\u00f6rigen-Expert/innen PGV03.078",
          "DZ SUCHT",
          "EMIA"
        ),
        longitude = c(8.5410422,
                      7.3588795, 7.4521749, NA, 6.957368),
        latitude = c(47.3744489,
                     46.2311749, 46.9484742, NA, 47.184604),
        geometry = structure(
          list(
            structure(c(8.5410422, 47.3744489), class = c("XY", "POINT",
                                                          "sfg")),
            structure(c(7.3588795, 46.2311749), class = c("XY",
                                                          "POINT", "sfg")),
            structure(c(7.4521749, 46.9484742), class = c("XY",
                                                          "POINT", "sfg")),
            structure(c(NA_real_, NA_real_), class = c("XY",
                                                       "POINT", "sfg")),
            structure(c(6.957368, 47.184604), class = c("XY",
                                                        "POINT", "sfg"))
          ),
          class = c("sfc_POINT", "sfc"),
          precision = 0,
          bbox = structure(
            c(
              xmin = 6.957368,
              ymin = 46.2311749,
              xmax = 8.5410422,
              ymax = 47.3744489
            ),
            class = "bbox"
          ),
          crs = structure(
            list(input = "EPSG:4326", wkt = "GEOGCRS[\"WGS 84\",\n    ENSEMBLE[\"World Geodetic System 1984 ensemble\",\n        MEMBER[\"World Geodetic System 1984 (Transit)\"],\n        MEMBER[\"World Geodetic System 1984 (G730)\"],\n        MEMBER[\"World Geodetic System 1984 (G873)\"],\n        MEMBER[\"World Geodetic System 1984 (G1150)\"],\n        MEMBER[\"World Geodetic System 1984 (G1674)\"],\n        MEMBER[\"World Geodetic System 1984 (G1762)\"],\n        MEMBER[\"World Geodetic System 1984 (G2139)\"],\n        ELLIPSOID[\"WGS 84\",6378137,298.257223563,\n            LENGTHUNIT[\"metre\",1]],\n        ENSEMBLEACCURACY[2.0]],\n    PRIMEM[\"Greenwich\",0,\n        ANGLEUNIT[\"degree\",0.0174532925199433]],\n    CS[ellipsoidal,2],\n        AXIS[\"geodetic latitude (Lat)\",north,\n            ORDER[1],\n            ANGLEUNIT[\"degree\",0.0174532925199433]],\n        AXIS[\"geodetic longitude (Lon)\",east,\n            ORDER[2],\n            ANGLEUNIT[\"degree\",0.0174532925199433]],\n    USAGE[\n        SCOPE[\"Horizontal component of 3D system.\"],\n        AREA[\"World.\"],\n        BBOX[-90,-180,90,180]],\n    ID[\"EPSG\",4326]]"),
            class = "crs"
          ),
          n_empty = 1L
        )
      ),
      row.names = c(NA,
                    -5L),
      sf_column = "geometry",
      agr = structure(
        c(
          short_title = NA_integer_,
          longitude = NA_integer_,
          latitude = NA_integer_
        ),
        class = "factor",
        levels = c("constant",
                   "aggregate", "identity")
      ),
      class = c("sf", "tbl_df", "tbl", "data.frame")
    )

  # Load the toy cantons geometry
  data("toy_cantons_sf")

  #' @description Testing that there is a message if there is an issue
  expect_message(
    get_canton_main_resp_orga(
      data = toy_data,
      cantons_sf = toy_cantons_sf
    ),
    regexp = "1 project.s is.are not associated to a GPS point"
  )

  #' @description Testing that there is no error in an usual case
  expect_error(
    res_toy_data <- get_canton_main_resp_orga(
      data = toy_data,
      cantons_sf = toy_cantons_sf
    ),
    regexp = NA
  )

  #' @description Testing that the feature provide the expected output
  expect_equal(
    object = res_toy_data$id_canton,
    expected = c(
      "CH.ZH",
      "CH.VS",
      "CH.BE",
      NA,
      "CH.BE"
    )
  )

})
