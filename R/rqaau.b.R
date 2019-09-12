
# This file is a generated template, your changes will not be overwritten

rqaAUClass <- if (requireNamespace("jmvcore")) {
  R6::R6Class(
    "rqaAUClass",
    inherit = rqaAUBase,
    private = list(
      .run = function() {

        if (is.null(self$options$y1)){
          return(FALSE)
        }

        library(invctr)
        data        <- self$data
        standardise <- "none"

        # Variables ----
        y1 <- self$options$y1

        if(!plyr::is.discrete(data[[y1]])){
          y1vec <- jmvcore::toNumeric(data[[y1]])
        } else {
          if(is.factor(data[[y1]])){
            y1vec <- as.factor(data[[y1]])
          } else {
            y1vec <- as.character(data[[y1]])
          }
          y1Vlevel <- "Unordered categorical"
        }


        if(!any(plyr::is.discrete(y1vec),is.numeric(y1vec))){
          y1vec <- data[[y1]]
          y1Vlevel <- "Unordered categorical"
        }


        if(self$options$standardise=="none"){
          standardise <- "none"
        }

        if(is.numeric(y1vec)){

          y1Vlevel <- ifelse(all(is.wholenumber(y1vec)),"Discrete","Continuous")

          if(self$options$standardise=="meanSD"){
            standardise <- "mean.sd"
          }
          if(self$options$standardise=="medianMAD"){
            standardise <- "median.mad"
          }

          if(self$options$standardise=="unitScale"){
            y1vec <- elascer(y1vec)
            standardise <- "unit scale"
            y1Vlevel <- "Continuous"
          }

          if(self$options$standardise=="symbolicScale"){
            y1vec <- ts_symbolic(y1vec)
            y1vec <- y1vec[!is.na(y1vec)]

            standardise <- "symbolic"
            y1Vlevel <- "Ordered categorical"
          }

          if(any(standardise%in%c("mean.sd","median.mad"))){
            y1vec <- ts_standardise(y1vec, type = standardise,  adjustN = FALSE)
            y1Vlevel <- "Continuous"
          }
        }

        if(plyr::is.discrete(y1vec)&self$options$standardise!="symbolicScale"){
          y1Vlevel <- "Unordered categorical"
          if(is.factor(y1vec)){
            y1vec <- as.numeric_factor(y1vec)
            allvalues <- sort(unique(y1vec))
            y1vec <- factor(y1vec,labels = paste0(allvalues), levels = allvalues, ordered = is.ordered(data[[y1]]))
            if(is.ordered(y1vec)){
              y1Vlevel <- "Ordered categorical"
            }
          }
          if(is.character(y1vec)){
            allvalues <- as.numeric_character(sort(unique(c(y1vec))))
            y1vec <- factor(y1vec,labels = names(allvalues), levels = names(allvalues), ordered = is.ordered(data[[y1]]))
            if(is.ordered(y1vec)){
              y1Vlevel <- "Ordered categorical"
            }
          }
        }
#
#         if((!plyr::is.discrete(data[[y1]]))&self$options$discretise){
#           data[[y1]] <- ts_symbolic(data[[y1]])
#           v1_discretised <- "yes"
#         }
#
#         if(is.factor(data[[y1]])|is.character(data[[y1]])){
#           if(is.factor(data[[y1]])&is.ordered(data[[y1]])){
#             y1Vlevel <- "Ordered categorical"
#           } else {
#             y1Vlevel <- "Unordered categorical"
#           }
#         }
#         if(is.numeric(data[[y1]])){
#           y1Vlevel <- typeof(data[[y1]])
#         }

        TStable <- self$results$tblTS

        # Time Series table ----
        TStable$setRow(rowNo=1,
                       values=list(
                         var = y1,
                         vlevel = y1Vlevel,
                         N   = NROW(na.omit(data[[y1]])),
                         na  = sum(is.na(data[[y1]])),
                         uni_obs = length(unique(na.omit(data[[y1]]))),
                         transformed = standardise)
        )

        tsData <- data.frame(t  = seq_along(y1vec),
                             y1 = y1vec,
                             label = rep(y1,length(y1vec))
                             )
        # tsImage <- self$results$tsplot
        # tsImage$setState(tsData)

        emLag <- self$options$emLag
        emDim <- self$options$emDim
        if(emDim<=0){emDim<-1}

        emRad <- NULL
        if(self$options$fixed%in%"RAD"){
          emRad <- self$options$fixRAD
          #if(emRad<=0){emRad<-emRad+.Machine$double.eps}
        }
        if(self$options$fixed%in%"RR"){
          emRad <- crqa_radius(y1 = tsData$y1, emLag = emLag, emDim = emDim, targetValue = self$options$fixRR)$Radius
        }
        if(self$options$fixed%in%"NO"){
          RM <- rp(y1 = tsData$y1, emDim = emDim, emLag = emLag, method = as.character(self$options$norm))
        } else {
          RM <- rp(y1 = tsData$y1, emDim = emDim, emLag = emLag, emRad = emRad, method = as.character(self$options$norm))

         }

        rpImage <- self$results$rpplot
        rpImage$setState(RM)

        if(!is.null(emRad)){

        if(self$options$DLmax<=0){
          DLmax <- length(Matrix::diag(RM))-1
        }
        if(self$options$VLmax<=0){
          VLmax <- length(Matrix::diag(RM))-1
        }
        if(self$options$HLmax<=0){
          HLmax <- length(Matrix::diag(RM))-1
        }

        crqa_all <- crqa_rp(RM = RM,emRad = emRad,
                            DLmin = self$options$DLmin, DLmax = DLmax,
                            VLmin = self$options$VLmin, VLmax = VLmax,
                            HLmin = self$options$HLmin, HLmax = HLmax,
                            theiler = self$options$theiler,
                            matrices = TRUE)
        crqa_out <- crqa_all$crqaMeasures

        RPtable <- self$results$tblRP

        RPtable$setRow(rowNo=1,
                        values = list(
                          emRad = emRad,
                          RP = crqa_out$RP_N,
                          RN = rp_size(RM, AUTO=TRUE),
                          RR = crqa_out$RR,
                          SING = crqa_out$SING_N,
                          DIV = crqa_out$DIV_dl,
                          REP = crqa_out$REP_av,
                          ANI = crqa_out$ANI)
        )

        RQAtable <- self$results$tblRQA

        RQAtable$setRow(rowNo=1,
                        values = list(
                          LineType = "Diagonal",
                          NLines = crqa_out$N_dl,
                          Npoints = crqa_out$N_dlp,
                          Measure = "Determinism",
                          PoL = crqa_out$DET,
                          MEAN = crqa_out$MEAN_dl,
                          MAX = crqa_out$MAX_dl,
                          ENT = crqa_out$ENT_dl,
                          relENT = crqa_out$ENTrel_dl,
                          CoV    = crqa_out$CoV_dl)
                        )

        RQAtable$setRow(rowNo=2,
                        values = list(
                          LineType = "Vertical",
                          NLines = crqa_out$N_vl,
                          Npoints = crqa_out$N_vlp,
                          Measure = "V Laminarity",
                          PoL = crqa_out$LAM_vl,
                          MEAN = crqa_out$TT_vl,
                          MAX = crqa_out$MAX_vl,
                          ENT = crqa_out$ENT_vl,
                          relENT = crqa_out$ENTrel_vl,
                          CoV    = crqa_out$CoV_vl)
        )

        RQAtable$setRow(rowNo=3,
                        values = list(
                          LineType = "Horizontal",
                          NLines = crqa_out$N_hl,
                          Npoints = crqa_out$N_hlp,
                          Measure = "H Laminarity",
                          PoL = crqa_out$LAM_hl,
                          MEAN = crqa_out$TT_hl,
                          MAX = crqa_out$MAX_hl,
                          ENT = crqa_out$ENT_hl,
                          relENT = crqa_out$ENTrel_hl,
                          CoV    = crqa_out$CoV_hl)
                        )

          dpImage <- self$results$DPplot

        if(self$options$plotDP==FALSE){
          dpImage$setVisible(visible=FALSE)
        } else {
          dpImage$setVisible(visible=TRUE)
          dpImage$setState(RM)
        }

        }
      },

      .rpplot=function(rpImage, ...) {

        ready <- TRUE
        rm <- rpImage$state

        if(is.null(self$options$y1)){
          ready <- FALSE
        }

        if(ready){

          rm <- rpImage$state

          RadiusRRbar <- FALSE
          if(self$options$fixed%in%"NO"){
            RadiusRRbar <- TRUE
          }

       #   if(plyr::is.discrete(df$y1)){

          rppl <- rp_plot(rm, plotDimensions = TRUE, xlab = self$options$y1, ylab = self$options$y1, radiusValue = attributes(rm)$emRad, plotRadiusRRbar = RadiusRRbar)

          print(rppl)
          TRUE
        }
      },

      .DPplot=function(dpImage, ...) {

        ready <- TRUE
        dp <- dpImage$state

        if(any(is.null(self$options$y1),self$options$plotDP==FALSE)){
          ready <- FALSE
        }

        if(ready){

          dp <- dpImage$state

          dppl <-  crqa_diagPofile(dp,diagWin = self$options$diagWin, xname = self$options$y1, yname  = self$options$y1)

          print(dppl)
          TRUE
        }
      }
    )
  )
}
