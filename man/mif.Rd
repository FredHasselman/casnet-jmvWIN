% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mrn.R
\name{mif}
\alias{mif}
\title{Mutual Information Function}
\usage{
mif(
  y,
  lags = -10:10,
  nbins = ceiling(2 * NROW(y)^(1/3)),
  doPlot = FALSE,
  surTest = FALSE,
  alpha = 0.05
)
}
\arguments{
\item{y}{A \code{Nx1} matrix for auto-mif, a \code{Nx2} matrix or data frame for cross-mif, a \code{Nx3} matrix or data frame for mif between col 1 and 2 conditional on col 3; or a \code{NxM} matrix or data frame for the multi-information function. Mutual information for each lag will be calculated using functions in package \code{\link[infotheo:infotheo]{infotheo::infotheo()}} for \code{lags} lagged versions of the time series.}

\item{lags}{The lags to evaluate mutual information.}

\item{nbins}{The number of bins passed to \code{\link[infotheo:discretize]{infotheo::discretize()}} if y is a matrix or \code{\link[casnet:ts_discrete]{casnet::ts_discrete()}}}

\item{doPlot}{Produce a plot of the symbolic time series by calling \code{\link[=plotRED_mif]{plotRED_mif()}} (default = \code{FALSE})}

\item{surTest}{If \code{TRUE}, a surrogate will be conducted using simple surrogates. The surrogates will be created from the transition probabilities of the discretised time series, i.e. the probability of observing bin \code{j} when the current value is in bin \code{j}. The number of surrogates needed will be computed based on the value of the \code{alpha} parameter, conceived as a one-sided test: \code{mi > 0}.}

\item{alpha}{The alpha level for the surrogate test (default = \code{0.05})}
}
\value{
The auto- or cross-mi function
}
\description{
Calculate the lagged mutual information fucntion within (auto-mif) or between (cross-mif) time series, or, conditional on another time series (conditional-cross-mif). Alternatively, calculate the total information of a multivariate dataset for different lags.
}
\examples{

# Lags to evaluate mututal information
lags <- -10:30

# Auto-mutual information
y1 <- sin(seq(0, 100, by = 1/8)*pi)

(mif(data.frame(y1),lags = lags))

# Cross-mututal information, y2 is a lagged version y1
y2 <- y1[10:801]

y <- data.frame(ts_trimfill(y1, y2, action = "trim.cut"))
(mif(y,lags = lags))

# Conditional mutual information, add some noise to y2 and add it as a 3rd column
y$s <- y2+rnorm(NROW(y2))
(mif(y,lags = lags))

# Multi-information, the information of the entire multivariate series at each lag
y$y3 <- cumsum(rnorm(NROW(y)))
(mif(y,lags = lags))


}
\seealso{
Other Redundancy measures (mutual information): 
\code{\link{mi_interlayer}()},
\code{\link{mi_mat}()}
}
\concept{Redundancy measures (mutual information)}
