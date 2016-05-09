
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
