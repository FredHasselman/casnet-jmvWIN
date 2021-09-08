
# This file is a generated template, your changes will not be overwritten

faSDAClass <- if (requireNamespace("jmvcore")) {
  R6::R6Class(
    "faSDAClass",
    inherit = faSDABase,
    private = list(
      .run = function() {

        if(is.null(self$options$y1)){
          return(FALSE)
        } else {

          y1   <- self$options$y1
          data <- self$data

          # convert to appropriate data types
          data[[y1]] <- jmvcore::toNumeric(data[[y1]])
          data <- na.omit(data)

          #self$options$maxScale <- (floor(log2(NROW(data[[y1]])/2)))
          if(self$options$standardise=="meanSD"){
            standardise <- "mean.sd"
          }
          if(self$options$standardise=="medianMAD"){
            standardise <- "median.mad"
          }
          if(self$options$standardise=="none"){
            standardise <- "none"
          }

          if(self$options$minScale=="autoMin"){
            scaleMin <- 2
            scaleMax <- floor(log2(NROW(data[[y1]])/2))
            ScaleRange <- unique(round(2^(seq(scaleMin, scaleMax, by=((scaleMax-scaleMin)/self$options$scaleRES)))))
            # We want a minimum of 15 datapoints
            if(length(ScaleRange)%[]%c(15,30)){
              scaleMin <- 2
            }
            if(length(ScaleRange)>30){
              scaleMin <- 3
            }
            if(length(ScaleRange)<15){
              scaleMin <- 1
            }
          } else {
            scaleMin <- self$options$userMinScale
          }

          if(self$options$maxScale=="autoMax"){
            scaleMax <- floor(log2(NROW( data[[y1]])/2))
          } else {
            scaleMax <- self$options$userMaxScale
          }

          if(self$options$removeTrend=="polydet"){
            polyOrder <- self$options$polydet_order
            detrend <- TRUE
          } else {
            polyOrder <- NA
            detrend <- FALSE
          }

          if(scaleMax>scaleMin&scaleMax<NROW(data[[y1]])){

            results <- fd_sda(y=data[[y1]],
                              fs = NULL,
                              standardise = standardise,
                              detrend = detrend,
                              polyOrder= polyOrder,
                              adjustSumOrder = self$options$sumORDER,
                              scaleMin = scaleMin,
                              scaleMax = scaleMax,
                              scaleResolution = self$options$scaleRES,
                              scaleS = NA,
                              overlap = 0,
                              minData = self$options$scaleExclude,
                              doPlot = FALSE,
                              returnPlot = TRUE,
                              returnPLAW = TRUE,
                              returnInfo = FALSE,
                              silent = TRUE,
                              noTitle = TRUE,
                              tsName = y1)


            # Descriptives ----
            tableTS <- self$results$tblTS

            tableTS$setRow(rowNo=1,
                           values=list(
                             var = y1,
                             N   = NROW(na.omit(data[[y1]])),
                             na  = sum(is.na(data[[y1]])),
                             median = stats::median(data[[y1]],na.rm = TRUE),
                             mad = stats::mad(data[[y1]],na.rm = TRUE),
                             mean = mean(data[[y1]],na.rm = TRUE),
                             sd = stats::sd(data[[y1]],na.rm = TRUE),
                             standardise = standardise))

            y_ori <- results$plots$g1$data$y

            tableTS$setRow(rowNo=2,
                           values=list(
                             var = paste(y1,""),
                             N   = NROW(na.omit(y_ori)),
                             na  = sum(is.na(data[[y1]])),
                             median = stats::median(y_ori,na.rm = TRUE),
                             mad = stats::mad(y_ori,na.rm = TRUE),
                             mean = mean(y_ori,na.rm = TRUE),
                             sd = stats::sd(y_ori,na.rm = TRUE),
                             standardise = ""))

            # SDA ----
            tableSDA <- self$results$tblSDA

            tableSDA$setRow(rowNo=1,
                            values=list(
                              method = results[[2]]$method,
                              Hadjust = results[[2]]$Hadj,
                              detrending = paste(self$options$removeTrend,"(order = ",polyOrder,")"),
                              minScale = scaleMin,
                              maxScale = scaleMax,
                              slope = results[[2]]$sap,
                              H = results[[2]]$H,
                              FD = results[[2]]$FD))


            tableSDA$setRow(rowNo=2,
                            values=list(
                              method = results[[3]]$method,
                              Hadjust = results[[3]]$Hadj,
                              detrending = paste(self$options$removeTrend,"(order = ",polyOrder,")"),
                              minScale = scaleMin,
                              maxScale = scaleMax,
                              slope = results[[3]]$sap,
                              H = results[[3]]$H,
                              FD = results[[3]]$FD))

            #self$results$DFAout$setContent(results)

            tsImage <- self$results$tsplot
            #tsImage$setState(results$plots$g1)
            tsImage$setState(results$tsdata)

            sdaImage <- self$results$sdaplot
            sdaImage$setState(results$plots$g2)


          } else {
            return(FALSE)
          }
        }
   },

      .tsplot=function(tsImage, ...) {

        if(is.null(self$options$y1)){return(FALSE)}

        # g1 <- tsImage$state
        # print(g1)

        tsData <- tsImage$state

        plot <- ggplot2::ggplot(tsData, ggplot2::aes_(x=~x,y=~y)) +
          ggplot2::geom_line() +
          ggplot2::facet_grid(label ~ ., scales = "free") +
          ggplot2::scale_x_continuous("Time", expand=c(0,0)) +
          ggplot2::scale_y_continuous("", expand=c(0,0)) +
          # ggplot2::ggtitle(label = title,
          #                 subtitle = paste0("Standardisation: ",standardise, " | Detrended: ",ifelse(detrend,paste("Yes (order = ",polyOrder),"No"))) +
          ggplot2::theme_bw() +
          ggplot2::theme(strip.text = ggplot2::element_text(face="bold"))

        #print(g1)
        print(plot)
        TRUE
      },

      .sdaplot=function(sdaImage, ...) {

        if(is.null(self$options$y1)){return(FALSE)}

        g2 <- sdaImage$state
        print(g2)
        TRUE
      }
    )
  )
}
