data("vfq_example")

input <- list(vfq_example, vfq_example[1:3,])

test_that("number of rows is retained", {
  for (i in input) {
    o <- vfq::evaluate_raw_data(i)
    expect_equal(nrow(i), nrow(o))
  }
})
