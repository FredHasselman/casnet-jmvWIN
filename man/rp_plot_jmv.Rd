% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/casnet_SOURCE_jamovi.R
\name{rp_plot_jmv}
\alias{rp_plot_jmv}
\title{Plot (thresholded) distance matrix as a recurrence plot}
\usage{
rp_plot_jmv(RM, plotDimensions = FALSE, plotMeasures = FALSE,
  plotRadiusRRbar = TRUE, drawGrid = FALSE, markEpochsLOI = NULL,
  Chromatic = NULL, radiusValue = NA, title = "", xlabel = "",
  ylabel = "", plotSurrogate = NA, returnOnlyObject = FALSE)
}
\arguments{
\item{RM}{A distance matrix or recurrence matrix}

\item{plotDimensions}{Should the state vectors be plotted if they are available as attributes of RM (default = `TRUE`)}

\item{plotMeasures}{Print common (C)RQA measures in the plot if the matrix is binary}

\item{plotRadiusRRbar}{The `Radius-RR-bar` is a colour-bar guide plotted with an unthresholded distance matrix indicating a number of `RR` values one would get if a certain distance threshold were chosen (`default = TRUE`)}

\item{drawGrid}{Draw a grid on the recurrence plot (`default = FALSE`)}

\item{markEpochsLOI}{Pass a factor whose levels indicate different epochs or phases in the time series and use the line of identity to represent the levels by different colours (`default = NULL`)}

\item{Chromatic}{If `TRUE` and there are more than two discrete values in `RM`, give recurrent points a distinct colour. If `RM` was returned by `crqa_rp(..., chromatic = TRUE)`, the recurrence plot will colour-code recurrent points according to the category values in `attributes(RM)$chromaticRP` (`default = FALSE`)}

\item{radiusValue}{If `plotMeasures = TRUE` and RM is an unthresholded matrix, this value will be used to calculate recurrence measures. If `plotMeasures = TRUE` and RM is already a binary recurence matrix, pass the radius that was used as a threshold to create the matrix for display purposes. If `plotMeasures = TRUE` and `radiusValue = NA`, function `est_radius()` will be called with default settings (find a radius that yields .05 recurrence rate). If `plotMeasures = FALSE` this setting will be ignored.}

\item{title}{A title for the plot}

\item{xlabel}{An x-axis label}

\item{ylabel}{An y-axis label}

\item{plotSurrogate}{Should a 2-panel comparison plot based on surrogate time series be added? If `RM` has attributes `y1` and `y2` containing the time series data (i.e. it was created by a call to [rp()]), the following options are available: "RS" (random shuffle), "RP" (randomised phases), "AAFT" (amplitude adjusted fourier transform). If no timeseries data is included, the columns will be shuffled.  NOTE: This is not a surrogate test, just 1 surrogate is created from `y1`.}

\item{returnOnlyObject}{Return the ggplot object only, do not draw the plot (default = `TRUE`)}
}
\value{
A nice plot of the recurrence matrix.
}
\description{
Plot (thresholded) distance matrix as a recurrence plot
}
\seealso{
Other Distance matrix operations (recurrence plot): \code{\link{di2bi}},
  \code{\link{di2we}}
}
\concept{Distance matrix operations (recurrence plot)}
