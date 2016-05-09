library(stringr)
library(readstata13)
library(foreach)

read.ipums <- function(datafile, dtype=NA, lowercase.colnames=TRUE, codebook=NA, include.columns=NA, exclude.columns=NA) {
  raw_df <- load.datafile(datafile, include.columns, exclude.columns, dtype)
}

# PRIVATE FUNCTIONS
load.datafile <- function(filepath, dtype=NA) {
  # TODO: what if filepath too short?

  if(is.na(dtype)) {
    if (nchar(filepath) < 4){
      return(NA)
    }
    end <- substr(filepath, nchar(filepath)-3+1, nchar(filepath))
    if(tolower(end) == "csv") {
      dtype <- "csv"
    } else if(tolower(end) == "dta") {
      dtype <- "dta"
    } else {
      # TODO: invalid filetype?
    }
  }

  if(dtype == "csv") {
    return(read.csv(filepath))
  } else if(dtype == "dta") {
    return(read.dta13(file = "census.dta"))
  }

}

load.codebook <- function(filepath, lowercase.colnames=TRUE) {
  begin.line <- "All Years \\. - not"
  var.line <- "[\\s]*(\\S+)[ \\t]+(\\S+.*)"

  is.begin <- function(curr.line) {
    curr.match <- grep(begin.line, curr.line, value = FALSE)
    toreturn <- (length(curr.match) > 0)
    return(toreturn)
  }

  get.vars <- function(curr.line) {
    curr.match <- str_match_all(curr.line, var.line)
    return(curr.match[[1]])
  }

  mode <- "initial"
  ans <- list()
  curr.var <- NA

  conn <- file(filepath,open="r")
  linn <-readLines(conn)
  for (i in 1:length(linn)){
    curr.line <- linn[i]

    if (nchar(curr.line) == 0) {
      if(mode != "initial") {
        mode <- "header"
      }
      next()
    }
    if (is.begin(curr.line)) { # TODO
      mode <- "header"
    } else if (mode == "header") {
      var.groups <- get.vars(curr.line)
      if (length(var.groups) > 2) {
        curr.var <- var.groups[[2]]
        if(lowercase.colnames) {
          curr.var <- tolower(curr.var)
        }
        ans[[curr.var]] <- list()
        mode <- "reading"
      }
    } else if (mode == "reading") {
      var.groups <- get.vars(curr.line)
      if (length(var.groups) > 2) {

        key <- var.groups[[2]]
        if(suppressWarnings(!is.na(as.integer(key)))){
          key <- toString(as.integer(key))
        }
        val <- var.groups[[3]]
        ans[[curr.var]][key] <- val
      }
    }
  }
  close(conn)
  return(ans)
}

codebook.decode <- function(codebook, colname, key) {
  variable.dict <- codebook[[colname]]
  ans <- variable.dict[[toString(key)]]
  if(is.null(ans)){
    return(key)
  }
  return(ans)
}

codebook.decodedf <- function(ipumsdf, codebook) {
  to.convert <- names(codebook)

  convert <- function(row, colname) {
    curr.val <- row[[colname]]
    new.val <- codebook.decode(codebook, colname, curr.val)
    return(new.val)
  }

  for(colname in to.convert){

    converted.column <- apply(ipumsdf, 1, convert, colname=colname)
    ipumsdf[colname] <- converted.column
  }


  return(ipumsdf)
}
