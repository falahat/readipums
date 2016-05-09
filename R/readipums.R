library(stringr)

read.pums <- function(datafile, dtype=NA, lowercase.colnames=TRUE, codebook=NA, include.columns=NA, exclude.columns=NA) {
  raw_df <- load.datafile(datafile, include.columns, exclude.columns, dtype)
}

# PRIVATE FUNCTIONS
load.datafile <- function(filepath, include.columns=NA, exclude.columns=NA, dtype=NA) {

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
  if(is.na(variable.dict)){
    return(NA)
  }
  return(variable.dict[[key]])
}

codebook.decodedf <- function(ipumsdf, codebook) {

}
