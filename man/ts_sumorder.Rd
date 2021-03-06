% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/casnet_SOURCE_jamovi.R
\name{ts_sumorder}
\alias{ts_sumorder}
\title{Adjust time series by summation order}
\usage{
ts_sumorder(y, scaleS = NULL, polyOrder = 1, minData = minData)
}
\arguments{
\item{y}{A time series of numeric vector}

\item{scaleS}{The scales to consider for \code{DFA1}}

\item{polyOrder}{Order of polynomial for detrending in DFA (default = \code{1})}
}
\value{
The input vector, possibly adjusted based on \code{H} with an attribute \code{"Hadj"} containing an integer by which a Hurst exponent calculated from the series should be adjusted.
}
\description{
Many fluctuation analyses assume a time series' Hurst exponent is within the range of \code{0.2 - 1.2}. If this is not the case it is sensible to make adjustments to the time series, as well as the resutling Hurst exponent.
}
\details{
Following recommendations by [Ihlen (2012)](https://www.frontiersin.org/files/Articles/23948/fphys-03-00141-r2/image_m/fphys-03-00141-t001.jpg), a global Hurst exponent is estimated using DFA and \code{y} is adjusted accordingly:
\itemize{
\item{\code{1.2 < H < 1.8} first derivative of y, atribute \code{Hadj = 1}}
\item{\code{H > 1.8} second derivative of y, atribute \code{Hadj = 2}}
\item{\code{H < 0.2} y is centered and integrated, atribute \code{Hadj = -1}}
\item{\code{0.2 <= H <= 1.2 } y is unaltered, atribute \code{Hadj = 0}}
}
}
\references{
Ihlen, E. A. F. E. (2012). Introduction to multifractal detrended fluctuation analysis in Matlab. Frontiers in physiology, 3, 141.
}
