data("vfq_example")

r1 <- vfq_example
r2 <- vfq::evaluate_raw_data(r1)
r3 <- vfq::evaluate_scores(r2)

test_that("Names tested", {
  # should be ok
  expect_true(correct_naming(r1, "raw"))
  expect_true(correct_naming(r2, "eval"))
  expect_true(correct_naming(r3, "score"))
  # wrong type
  expect_false(correct_naming(r1, "eval"))
  expect_false(correct_naming(r2, "score"))
  expect_false(correct_naming(r3, "raw"))
  # bad type
  expect_error(correct_naming(r1, "basic"))
  expect_error(correct_naming(r2, "evaluated"))
  expect_error(correct_naming(r3, "scores"))
})
