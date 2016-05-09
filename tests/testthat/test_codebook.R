library(testthat)
library(readipums)

test_that("sample codebook can be loaded", {
  codebook <- load.codebook("./sample.cbk")
  expect_length(codebook, 2) # TODO: find actual number

  expect_equal(codebook.decode("degfieldd", "2310"), "Special Needs Education")
  expect_equal(codebook.decode("labforce", "1"), "No, not in the labor force")
})
