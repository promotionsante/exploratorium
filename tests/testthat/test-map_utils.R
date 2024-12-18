test_that("Switzerland centroid are coherent between computation and accessor function", {
  expect_equal(
    compute_switzerland_centroid(),
    get_switzerland_centroid()
  )
})

test_that("Switzerland bounding box are coherent between computation and accessor function", {
  expect_equal(
    compute_switzerland_bounding_box(),
    get_switzerland_bounding_box()
  )
})
