# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

read.pums <- function(datafile, dtype=NA, lowercase.colnames=TRUE, codebook=NA, include.columns=NA, exclude.columns=NA) {
  raw_df <- load.datafile(datafile, include.columns, exclude.columns, dtype)
}

# PRIVATE FUNCTIONS
load.datafile <- function(filepath, include.columns=NA, exclude.columns=NA, dtype=NA) {

}

load.codebook <- function(filepath, lowercase.colnames=TRUE) {

}

apply.codebook <- function(ipumsdf, codebook) {

}


