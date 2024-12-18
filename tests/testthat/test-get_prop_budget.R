test_that("Test that the computation of the prop of the budget is ok", {
  toy_data <- data.frame(
    budget_gfch = c(1, 0, 0),
    budget_orga = c(2, 1, 0),
    budget_third_party = c(1, 0, 0)
  )

  res_prop_budget <- toy_data |>
    get_prop_budget()

  #' @description output is a tibble
  expect_s3_class(
    res_prop_budget,
    c("tbl_df", "tbl", "data.frame")
  )
  #' @description Data as been ungrouped properly
  expect_true(
    !("rowwise_df" %in% class(res_prop_budget))
  )

  res_prop_budget_check <- res_prop_budget |>
    mutate(
      sum_prop_budget = prop_budget_gfch + prop_budget_third_party + prop_budget_orga
    )

  #' @description Testing that the sum of all the proportion equals 1
  expect_true(
    object = all(res_prop_budget_check$sum_prop_budget %in% c(1, 0))
  )

  sum_full_zero_line <- sum(
    res_prop_budget_check[
      res_prop_budget_check$sum_prop_budget == 0,
    ]
  )

  #' @description In the edge case that all budget are not yet updated (== 0), the
  #' line sum should be 0 -> all proportions are set to 0
  expect_true(
    sum_full_zero_line == 0
  )
})
