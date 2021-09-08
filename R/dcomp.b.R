
# This file is a generated template, your changes will not be overwritten

dcompClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "dcompClass",
    inherit = dcompBase,
    private = list(
        .run = function() {

            data <- self$data

            if (is.null(self$options$deps)){
                return(FALSE)
            } else {
                if(self$options$dataDone){
                    # convert to appropriate data types
                    colIDs <- which(colnames(data)%in%self$options$deps)
                    df <- dplyr::select(data, colIDs)
                    df <- plyr::colwise(as.numeric)(df)
                    df <- na.omit(df)
                    #print(df)
                } else {
                    return(FALSE)
                }
            }

            if(self$options$minScale=="autoMin"){
                scaleMin <- min(data, na.rm = TRUE)
            } else {
                scaleMin <- self$options$userMinScale
            }

            if(self$options$maxScale=="autoMax"){
                scaleMax <- max(data, na.rm = TRUE)
            } else {
                scaleMax <- self$options$userMaxScale
            }

            if(self$options$win==0){
                win <- 4
            } else {
                win <- self$options$win
            }

            plotOrder <- self$options$Order

            colOrder <- TRUE
            switch(plotOrder,
                   data = colOrder <- TRUE,
                   alpha = colOrder <- FALSE,
                   means = colOrder <- NA)


            #             tsImage <- self$results$tsplot
            #             tsImage$setState(tsData)
            #
            #
            #
            #
            #             # Descriptives ----
            #             table <- self$results$tsdesc
            #
            #             y1Descriptives <- summary(data[[dv1]])
            #
            #             table$setRow(rowNo=1,
            #                          values=list(
            #                              var = dv1,
            #                              N   = NROW(na.omit(data[[dv1]])),
            #                              na  = sum(y1NA),
            #                              minimum = y1Descriptives[[1]],
            #                              q1 = y1Descriptives[[2]],
            #                              q3 = y1Descriptives[[5]],
            #                              maximum = y1Descriptives[[6]],
            #                              median = y1Descriptives[[3]],
            #                              mad = stats::mad(data[[dv1]],na.rm = TRUE),
            #                              mean = y1Descriptives[[4]],
            #                              sd = stats::sd(data[[dv1]],na.rm = TRUE)
            #                          ))


            # `self$data` contains the data
            # `self$options` contains the options
            # `self$results` contains the results object (to populate)

            if(self$options$dataDone){

                resultsWIN <- dc_win(df = df, scale_min = scaleMin, scale_max = scaleMax, win = win, colOrder = colOrder, doPlot = FALSE)
                resultsCCP <- dc_ccp(df = resultsWIN$dynamic_complexity, doPlot = FALSE)

                df$`MEAN Dynamic Complexity` <- rowMeans(resultsWIN$dynamic_complexity, na.rm = TRUE)


                if(NCOL(df)>1){
                    TSplot <- plotTS_multi(data.frame(df), colOrder = colOrder, doPlot = FALSE)
                } else {
                    TSplot <- ggplot(df, aes(x=1:NROW(df), y = select$options$deps)) + geom_line() + theme_bw()
                }

                tsImage <- self$results$tsplot
                #tsImage$setState(results$plots$g1)
                tsImage$setState(TSplot)

                crImage <- self$results$CRplot
                crImage$setState(resultsWIN$plot)

                ccpImage <- self$results$CCPplot
                ccpImage$setState(resultsCCP$plot)

                #self$options$dataDone <- FALSE

            } else {
                return(FALSE)
            }

        },

        .tsplot=function(tsImage, ...) {

            if(!self$options$dataDone){return(FALSE)}

            #g1 <- tsImage$state

            tsPlot <- tsImage$state

            print(tsPlot)
            TRUE
        },

        .CRplot=function(crImage, ...) {

            if(!self$options$dataDone){return(FALSE)}

            plot <- crImage$state

            #plot <- plotDC_res(df_win = plotData, win = self$options$win, colOrder = self$options$Order, doPlot = FALSE)

            print(plot)

        },

        .CCPplot=function(ccpImage, ...) {

            if(!self$options$dataDone){return(FALSE)}

            plot <- ccpImage$state

            #plot <- plotDC_ccp(df_ccp = plotData, win = self$options$win, colOrder = self$options$Order, doPlot = FALSE)

            print(plot)

        }
    )
)
