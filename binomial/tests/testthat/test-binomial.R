context("Testing binomial functions")

test_that("Testing bin_choose()", {
  expect_equal(bin_choose(5,2), 10)
  expect_equal(bin_choose(c(5,2), c(2, 1)), c(10, 2))
  expect_equal(length(bin_choose(c(5,2, 20), c(2, 1, 10))), 3)
  expect_error(bin_choose(2,5))
})

test_that("Testing bin_probability()", {
  expect_equal(bin_probability(2,5,0.5), 0.3125)
  expect_equal(bin_probability(0:2,5,0.5), c(0.03125, 0.15625, 0.31250))
  expect_equal(round(bin_probability(55, 100, 0.45), 3), 0.011)
  expect_error(bin_probability(2,5,3))
  expect_error(bin_probability(5,2,0.5))
})

test_that("Testing bin_distribution()", {
  expect_equal(class(bin_distribution(5,0.5)), c("bindis", "data.frame"))
  expect_equal(bin_distribution(2,0.5)$probability, c(0.25, 0.50, 0.25))
  expect_equal(length(bin_distribution(10, 0.5)$success), length(bin_distribution(10, 0.5)$probability))
  expect_equal(length(bin_distribution(10, 0.5)$success), 11)
  expect_equal(ncol(bin_distribution(10, 0.6)), 2)
})


test_that("Testing bin_cumulative()", {
  expect_equal(class(bin_cumulative(5,0.5)), c("bincum", "data.frame"))
  expect_equal(bin_cumulative(2,0.5)$probability, c(0.25, 0.50, 0.25))
  expect_equal(bin_cumulative(2,0.5)$cumulative, c(0.25, 0.75, 1.00))
  expect_equal(length(bin_cumulative(10, 0.5)$success), length(bin_cumulative(10, 0.5)$probability))
  expect_equal(length(bin_cumulative(10, 0.5)$cumulative), length(bin_cumulative(10, 0.5)$probability))
  expect_equal(length(bin_cumulative(10, 0.5)$success), 11)
  expect_equal(ncol(bin_cumulative(10, 0.6)), 3)
})

