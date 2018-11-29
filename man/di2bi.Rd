% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/casnet_SOURCE_jamovi.R
\name{di2bi}
\alias{di2bi}
\title{Distance to binary matrix}
\usage{
di2bi(distmat, emRad, theiler = 0, convMat = FALSE)
}
\arguments{
\item{distmat}{Distance matrix}

\item{emRad}{The radius or threshold value}

\item{theiler}{= Use a theiler window around the line of identity / synchronisation to remove high auto-correlation at short time-lags (default = \code{0})}

\item{convMat}{Should the matrix be converted from a \code{distmat} obkect of class \code{\link[Matrix]{Matrix}} to \code{\link[base]{matrix}} (or vice versa)}
}
\value{
A (sparse) matrix with only 0s and 1s
}
\description{
Distance matrix to binary matrix based on threshold value
}
\seealso{
Other Distance matrix operations: \code{\link{bandReplace}},
  \code{\link{di2we}}, \code{\link{dist_hamming}},
  \code{\link{rp_lineDist}}, \code{\link{rp_nzdiags}},
  \code{\link{rp_plot}}, \code{\link{rp_size}},
  \code{\link{rp}}
}
\concept{Distance matrix operations}