library(testthat)
library(readipums)
test_that("CSV datafiles should be loaded", {
  codebook <- load.datafile("./census.csv")
  expect_length(codebook, 27) # TODO: find actual number
})

test_that("STATA datafiles should be loaded", {
  codebook <- load.datafile("./census.dta")
  expect_length(codebook, 33) # TODO: find actual number
})
