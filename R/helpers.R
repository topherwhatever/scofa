#' returns the population standard deviation
#'
#' @param x a numeric vector
#'
#' @return a number
#' @export
#'
#' @examples sd.p(c(6,5.4,7,6666,29.3))
sd.p =function(x){
  sd(x)*sqrt((length(x)-1)/length(x))
}


## -- function to always round up from .5

#' Round up a numeric vector to a specified number of decimal places
#'
#' This function takes a numeric vector x and an integer n as inputs and returns a vector of the same length as x with each element rounded up to n decimal places
#'
#' @param x a numeric vector to be rounded up
#' @param n an integer specifying the number of decimal places to round up to
#'
#' @return a numeric vector of the same length as x with each element rounded up to n decimal places
#' @export
#'
#' @examples
#' round.up(c(1.23, 4.56, 7.89), 1) # returns c(1.3, 4.6, 7.9)
#' round.up(c(-1.23, -4.56, -7.89), 1) # returns c(-1.2, -4.5, -7.8)
round.up = function(x, n) {
  posneg = sign(x)
  z = abs(x)*10^n
  z = z + 0.5 + sqrt(.Machine$double.eps)
  z = trunc(z)
  z = z/10^n
  z*posneg
}

## -- function to assign elements of a list to the global environment

#' Assign the elements of a list to global environment by default
#' This function takes a list x and an environment envir as inputs and assigns each element of x to global environment with the same name as the element
#'
#' @param x a list whose elements will be assigned to global by default
#' @param envir an environment where the global variables will be created, default is the global environment
#'
#' @return NULL, the function has no output but creates global variables as a side effect
#' @export
#'
#' @examples lst2global(list(a = 1, b = 2, c = 3)) # creates global variables a, b and c with values 1, 2 and 3 respectively
lst2global <- function (x, envir = globalenv())
{
  x0 <- x
  names(x) <- NULL
  L <- length(x)
  for (cc in 1:L) {
    assign(names(x0)[cc], x[[cc]], envir = envir)
  }
}

## -- function to generate the indexes of all-missing columns
#' Find the column numbers of a data frame that have all missing values
#'
#'This function takes a data frame df as input and returns a vector of the column numbers that have all missing values (NA) in df
#' @param df df a data frame whose columns will be checked for missing values
#'
#' @return a vector of the column numbers that have all missing values in df
#' @export
#'
#' @examples
#' df <- data.frame(x = c(1, 2, NA), y = c(NA, NA, NA), z = c(3, 4, 5))
ColNums_AllMissing <- function(df){ # helper function
  as.vector(which(colSums(is.na(df)) == nrow(df)))
}

#' Add leading zeros to a vector or list
#' This function pads a vector with leading zeros using \code{stringr::str_pad()}.
#' @param x a list or vector of type string or numeric
#' @param width An integer. The desired width, in number of characters, of the output. If not provided, it is set to the maximum number of characters/digits in \code{x}.
#'
#' @return A vector of the same type as \code{x}, padded with leading zeros.
#' @export
#'
#' @examples
#' add_lead(c(1, 23, 456)) # returns c(“001”, “023”, “456”)
#' add_lead(c(1, 23, 456), width = 4) # returns c(“0001”, “0023”, “0456”)
#'
#' @importFrom stringr str_pad
#'
#' @seealso \code{\link{str_pad}}
add_lead <- function(x, width = NULL) {
  listcheck = is.list(x)
  # If width is not specified, set it to the maximum number of characters/digits in x
  if (is.null(width)) {
    width <- max(nchar(x))
  }

  # Pad with leading zeros using stringr::str_pad()
  x <- stringr::str_pad(x, width = width, side = "left", pad = "0")

  # If x is a list, return it as a list
  if (listcheck) {
    return(as.list(x))
  }
    return(x) # Otherwise, return x
}
