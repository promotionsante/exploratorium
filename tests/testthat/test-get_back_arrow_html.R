test_that("get_back_arrow_html works", {
  expect_s3_class(
    get_back_arrow_html(),
    c("html", "character")
  )
})
