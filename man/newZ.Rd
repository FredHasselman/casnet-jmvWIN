% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/casnet_SOURCE_jamovi.R
\name{newZ}
\alias{newZ}
\title{Create new vector based on resampling of the original data.}
\usage{
newZ(tM, n_bins)
}
\arguments{
\item{tM}{The output from \code{transM}; a \code{list} with elements \code{xn} and \code{MM}.}

\item{n_bins}{The number of bins to use; passed from \code{muti}.}
}
\value{
A vector of resampled values.
}
\description{
\code{newZ} creates new vector based on a transition matrix. It is a helper
  function for \code{muti}.
}
\author{
Mark Scheuerell (https://mdscheuerell.github.io/muti/)
}
\keyword{internal}
