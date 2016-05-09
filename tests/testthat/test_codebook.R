library(testthat)
library(readipums)


test_that("sample dataframe can be decoded", {
  codebook <- load.codebook("./sample.cbk", lowercase.colnames=FALSE)
  df <- load.datafile("./census.csv")
  df <- df[sample(nrow(df), 2000), ]


  decoded <- codebook.decodedf(df, codebook)
  expect_length(decoded, 27) # TODO: find actual number
})

test_that("sample codebook can be loaded", {
  codebook <- load.codebook("./sample.cbk")
  expect_length(codebook, 16) # TODO: find actual number

  print(codebook.decode(codebook, "degfieldd", "2310"))
  decoded <-codebook.decode(codebook, "degfieldd", "2310")
  expect_equal(codebook.decode(codebook, "degfieldd", "2310"), "Special Needs Education")
  expect_equal(codebook.decode(codebook, "labforce", "1"), "No, not in the labor force")
})
