
# This file is a generated template, your changes will not be overwritten

faPSDClass <- if (requireNamespace("jmvcore")) {
  R6::R6Class(
    "faPSDClass",
    inherit = faPSDBase,
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

          if(self$options$nfft=="user"){
            NFFT <- self$options$userNFFT
          } else {
            NFFT <- NA
          }

          if(self$options$removeTrend=="polydet"){
            polyOrder <- self$options$polydet_order
            detrend <- TRUE
          } else {
            polyOrder <- NA
            detrend <- FALSE
          }

          results <- fd_psd(y  = data[[y1]],
                            fs = self$options$fs,
                            standardise = standardise,
                            detrend = detrend,
                            polyOrder = polyOrder,
                            fitMethod = c("lowest25","Wijnants","Hurvich-Deo")[3],
                            doPlot = FALSE,
                            returnPlot = TRUE,
                            returnPLAW = TRUE,
                            returnInfo = FALSE,
                            silent = TRUE,
                            noTitle = TRUE,
                            tsName = y1)

          if(detrend){
            detr <- "Yes"
          } else {
            detr <- "No"
          }

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
                           standardise = standardise,
                           detrending = paste(detr,"(order = ",polyOrder,")")))

          y_ori <- results$plots$g1$data$y
          tableTS$setRow(rowNo=2,
                         values=list(
                           var = paste(y1,"adjusted"),
                           N   = NROW(na.omit(y_ori)),
                           na  = sum(is.na(data[[y1]])),
                           median = stats::median(y_ori,na.rm = TRUE),
                           mad = stats::mad(y_ori,na.rm = TRUE),
                           mean = mean(y_ori,na.rm = TRUE),
                           sd = stats::sd(y_ori,na.rm = TRUE),
                           standardise = "",
                           detrending = ""))

          # PSD ----
          tablePSD <- self$results$tblPSD

          antiper <- ifelse(results$analysis$antiper,"Yes","No")

          tablePSD$setRow(rowNo=1,
                          values=list(
                            method = results[[2]]$method,
                            antiper = antiper,
                            slope = results[[2]]$sap,
                            intercept = stats::coef(results[[2]]$fitlm1)[1],
                            H =  as.numeric(results[[2]]$H),
                            FD = results[[2]]$FD))

          tablePSD$setRow(rowNo=2,
                          values=list(
                            method = results[[3]]$method,
                            antiper = antiper,
                            slope = results[[3]]$sap,
                            intercept = stats::coef(results[[3]]$fitlm2)[1],
                            H = as.numeric(results[[3]]$H),
                            FD = results[[3]]$FD))

          #self$results$DFAout$setContent(results)

          tsImage <- self$results$tsplot
          #tsImage$setState(results$plots$g1)
          tsImage$setState(results$tsdata)



          psdImage <- self$results$psdplot
          psdImage$setState(results$plots$g2)
        }
      },

      .tsplot=function(tsImage, ...) {

        if(is.null(self$options$y1)){return(FALSE)}

        #g1 <- tsImage$state

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

      .psdplot=function(psdImage, ...) {

        if(is.null(self$options$y1)){return(FALSE)}

        plot <- psdImage$state

        #plotData <- data.frame(plotData)

        # logSlopes <- data.frame(x = c(data$PLAW$size[1:NROW(data[[2]]$fitlm1$fitted.values)],
        #                               data$PLAW$size[1:NROW(data[[3]]$fitlm2$fitted.values)]),
        #                         y = c(data$PLAW$bulk[1:NROW(data[[2]]$fitlm1$fitted.values)],
        #                               data$PLAW$bulk[1:NROW(data[[3]]$fitlm2$fitted.values)]),
        #                         Method = c(rep(data[[2]]$method,NROW(data[[2]]$fitlm1$fitted.values)),
        #                                    rep(data[[3]]$method,NROW(data[[3]]$fitlm2$fitted.values))))

        # breaksX <- unique(data$x[1:NROW(data)])
        # breaksY <- unique(data$y[1:NROW(data)])
        #
        # if(length(breaksX)>10){breaksX <- breaksX[seq.int(1,length(breaksX),length.out = 10)]}
        # if(length(breaksY)>10){breaksY <- breaksY[seq.int(1,length(breaksY),length.out = 10)]}
        #
        # logBase <- "10"
        # logFormat <- paste0("log",logBase)
        # logBaseNum <- as.numeric(logBase)
        # yAcc <- .1
        # xAcc <- 1


        # plot <- ggplot(plotData, aes(x=size,y=bulk), na.rm=TRUE) +
        #   geom_point() +
        #   geom_smooth(aes(colour = Method, fill = Method), method="lm", alpha = .2) +
        #   scale_x_log10("Frequencies") +
        #   scale_y_log10("Power") +
        #   theme_bw()

        # plot <- ggplot2::ggplot(data, ggplot2::aes_(x=~x,y=~x)) +
        #   ggplot2::geom_point()

          # ggplot2::ggtitle(label = "title", subtitle = "subtitle")
          # ggplot2::geom_smooth(ggplot2::aes(x=bulk,y=size, colour = Method, fill = Method), method="lm", alpha = .2) +
          # ggplot2::scale_x_continuous(name = paste0("xlabel"," (",logFormat,")"),
          #                             breaks = breaksX,
          #                             labels = scales::number_format(accuracy = xAcc),
          #                             trans = scales::log_trans(base = logBaseNum)) +
          # ggplot2::scale_y_continuous(name = paste0("ylabel"," (",logFormat,")"),
          #                             breaks = breaksY,
          #                             labels = scales::number_format(accuracy = yAcc),
          #                             trans = scales::log_trans(base = logBaseNum)) +
          # ggplot2::scale_color_manual(values = c("red3","steelblue")) +
          # ggplot2::scale_fill_manual(values = c("red3","steelblue")) +
          # ggplot2::theme_bw()
          # ggplot2::theme(panel.grid.minor =  ggplot2::element_blank(),
          #                legend.text = ggplot2::element_text(margin = ggplot2::margin(t = 5,b = 5, unit = "pt"), vjust = .5),
          #                plot.margin = ggplot2::margin(t = 5,b = 5, r = 5,l = 5, unit = "pt"))

        print(plot)
        TRUE
      }
    )
  )
}
