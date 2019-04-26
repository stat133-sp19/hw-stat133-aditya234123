context("Testing summary functions")

test_that("Testing aux_mean()", {
  expect_equal(aux_mean(10,0.3), 3)
  expect_equal(aux_mean(10, 0.4), 4)
  expect_error(aux_mean(10, 'wrong input'))
  expect_equal(length(aux_mean(10, 0.3)), 1)
})

test_that("Testing aux_variance()", {
  expect_equal(aux_variance(10,0.3), 2.1)
  expect_equal(aux_variance(10, 0.4), 2.4)
  expect_error(aux_variance(10, 'wrong input'))
  expect_equal(length(aux_variance(10, 0.3)), 1)
})

test_that("Testing aux_mode()", {
  expect_equal(aux_mode(10,0.3), 3)
  expect_equal(aux_mode(3, 0.5), c(2,1))
  expect_error(aux_mode(10, 'wrong input'))
  expect_equal(length(aux_mode(10, 0.3)), 1)
  expect_equal(length(aux_mode(1, 0.5)), 2)
})

test_that("Testing aux_skewness()", {
  expect_equal(round(aux_skewness(10,0.3), 3), 0.276)
  expect_equal(round(aux_skewness(10, 0.4), 3), 0.129)
  expect_error(aux_skewness(10, 'wrong input'))
  expect_equal(length(aux_skewness(10, 0.3)), 1)
})

test_that("Testing aux_kurtosis()", {
  expect_equal(round(aux_kurtosis(10,0.3), 3), -0.124)
  expect_equal(round(aux_kurtosis(10, 0.4), 3), -0.183)
  expect_error(aux_kurtosis(10, 'wrong input'))
  expect_equal(length(aux_kurtosis(10, 0.3)), 1)
})
