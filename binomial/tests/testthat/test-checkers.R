context("Testing check functions")

test_that("testing check_prob()", {
  expect_equal(check_prob(1) >= 0 & check_prob(1) <= 1, TRUE)
  expect_equal(length(check_prob(0.5)), 1)
  expect_error(check_prob(2))
})

test_that("testing check_trials()", {
  expect_error(check_trials(-3))
  expect_error(check_trials(3.4))
  expect_equal(check_trials(2), TRUE)
  expect_equal(length(check_trials(3)), 1)
})

test_that("testing check_success()", {
  expect_error(check_success(c(1, -3, 4), 5))
  expect_error(check_success(c(1, 3, 4), 3))
  expect_equal(check_success(c(1,2,3), 4), TRUE)
  expect_equal(length(check_success(c(1,2,3), 4)), 1)
})
