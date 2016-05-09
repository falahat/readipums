library(testthat)
library(readipums)
test_that("sample codebook can be loaded", {
  codebook <- load.codebook("./sample.cbk")
  expect_length(codebook, 16) # TODO: find actual number

  decoded <-codebook.decode(codebook, "degfieldd", "2310")
  print(decoded)
  expect_equal(codebook.decode(codebook, "degfieldd", "2310"), "Special Needs Education")
  expect_equal(codebook.decode(codebook, "labforce", "1"), "No, not in the labor force")
})
