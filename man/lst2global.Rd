% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/helpers.R
\name{lst2global}
\alias{lst2global}
\title{Assign the elements of a list to global environment by default
This function takes a list x and an environment envir as inputs and assigns each element of x to global environment with the same name as the element}
\usage{
lst2global(x, envir = globalenv())
}
\arguments{
\item{x}{a list whose elements will be assigned to global by default}

\item{envir}{an environment where the global variables will be created, default is the global environment}
}
\value{
NULL, the function has no output but creates global variables as a side effect
}
\description{
Assign the elements of a list to global environment by default
This function takes a list x and an environment envir as inputs and assigns each element of x to global environment with the same name as the element
}
\examples{
lst2global(list(a = 1, b = 2, c = 3)) # creates global variables a, b and c with values 1, 2 and 3 respectively
}
